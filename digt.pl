#!/usr/bin/perl -w

#  Copyright (C) 1999-2001 Jesper Christensen 
#
#  This script is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This script is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this script; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#  Author: Jesper Christensen <jesper@kalliope.org>
#
#  $Id$

use Kalliope;
use Kalliope::Poem;
use Kalliope::Page;
use Kalliope::Help;
use Net::SMTP;
use CGI qw(:standard);
use strict;

my $dbh = Kalliope::DB->connect;

my $MAILTAINER_EMAIL = 'jesper@kalliope.org';

my $poem = new Kalliope::Poem ('longdid' => url_param('longdid'));
$poem->updateHitCounter;
my $poet = $poem->author;
my $work = $poem->work;
my $LA = 'dk';
my ($longdid,$fhandle,$vhandle) = ($poem->longdid,$poet->fhandle,$work->longvid);

#
# Breadcrumbs -----------------------------------------------------------
#

my @crumbs;
push @crumbs,['Digtere','poets.cgi?list=az&sprog='.$poet->lang];
push @crumbs,[$poet->name,'ffront.cgi?fhandle='.$poet->fhandle];
push @crumbs,['V�rker','fvaerker.pl?fhandle='.$poet->fhandle];
push @crumbs,[$work->titleWithYear,'vaerktoc.pl?fhandle='.$poet->fhandle.'&vhandle='.$work->vhandle];
push @crumbs,[$poem->title,'digt.pl?longdid='.$poem->longdid];

my $page = newAuthor Kalliope::Page ( poet => $poet, crumbs => \@crumbs);

if (defined param('korrektur')) {
    my $mailBody = 'Dato:       '.localtime(time)."\n";
    $mailBody .= 'Remotehost: '.remote_host()."\n";
    $mailBody .= 'Forfatter:  '.$poet->name."\n";
    $mailBody .= 'Fhandle:    '.$poet->fhandle."\n";
    $mailBody .= 'V�rk:       '.$work->title.' '.$work->parenthesizedYear."\n";
    $mailBody .= 'V�rk-id:    '.$work->longvid."\n";
    $mailBody .= 'Digt:       '.$poem->title."\n";
    $mailBody .= 'Digt-id:    '.$poem->longdid."\n";
    $mailBody .= 'Korrektur:  '.param('korrektur')."\n";
    my $smtp = Net::SMTP->new('localhost') || last;
    $smtp->mail($MAILTAINER_EMAIL);
    $smtp->to($MAILTAINER_EMAIL);
    $smtp->data("From: Kalliope <$MAILTAINER_EMAIL>\r\n".
	    "To: $MAILTAINER_EMAIL\r\n".
	    "Subject: Korrektur $longdid\r\n".
	    "\r\n".$mailBody."\r\n");
    $smtp->quit;
    print STDERR $mailBody;
}

$page->addBox( width => '100%',
	       coloumn => 1,
               align => $poem->isProse ? 'justify' : 'left',
	       content => &poem($poem) );

my @keywords = $poem->keywords;

if ($poem->notes || $#keywords >= 0) {
    $page->addBox( width => '200',
	           coloumn => 2,
                   title => 'Noter',
	           content => &notes($poem,@keywords) );
}

my $workTitle = $work->titleWithYear;

$page->addBox( width =>'100%',
	       coloumn => 0,
               title => 'Indhold',
	       content => &tableOfContents($work),
	       end => qq|<A HREF="vaerktoc.pl?fhandle=$fhandle&vhandle=$vhandle"><IMG VALIGN=center ALIGN=left SRC="gfx/leftarrow.gif" BORDER=0 TITLE="$workTitle" ALT="$workTitle"></A>|
	     );

$page->addBox( width => '100%',
	       coloumn => 2,
	       content => &korrekturFelt($poem) );

$page->print;

#
# Boxes
#

sub poem {
    my $poem = shift;
    my $HTML;
    $HTML .= '<SPAN CLASS="digtoverskrift"><I>'.$poem->title."</I></SPAN><BR>";
    $HTML .= '<SPAN CLASS="digtunderoverskrift">'.$poem->subtitle.'</SPAN><BR>' if $poem->subtitle;
    $HTML .= '<BR>';
    $HTML .= $poem->content;
    return $HTML;
}

sub tableOfContents {
    my $work = shift;
    my $HTML;

    $HTML .= '<SPAN STYLE="font-size: 12px">';
    my $sth = $dbh->prepare("SELECT longdid,titel,afsnit,did FROM digte WHERE vid=? ORDER BY vaerkpos");
    $sth->execute($work->vid);
    while(my $d = $sth->fetchrow_hashref) {
	if ($d->{'afsnit'} && !($d->{'titel'} =~ /^\s*$/)) {
	    $HTML .= '<BR><FONT SIZE="+1"><I>'.$d->{'titel'}."</I></FONT><BR>";
	} else {
	    $HTML .= "&nbsp;" x 4;
	    if ($d->{'longdid'} eq $longdid) {
		$HTML .= $d->{'titel'} = "<B>".$d->{'titel'}."</B><BR>";
	    } else {
		$HTML .= "<A HREF=\"digt.pl?longdid=".$d->{'longdid'}."\">";
		$HTML .= $d->{'titel'}."</A><BR>";
	    }
	}
    }
    $sth->finish;
    $HTML .= "</SPAN>";
    return $HTML;
}

sub otherFormats {
    my ($poet,$poem) = @_;
    my ($longdid,$fhandle) = ($poem->longdid,$poet->fhandle);
    return qq|<A HREF="digtprinter.pl?fhandle=$fhandle&longdid=$longdid"><IMG SRC="gfxold/gfx/printer.gif" BORDER=0 ALT="Vis dette digt opsat p� en side lige til at printe ud."></A><BR>Printer venligt<BR>|;
}

sub korrekturFelt {
    my $poem = shift;
    my $HTML;
    if (defined param('korrektur')) {
	$HTML .= "<SMALL>Tak for din rettelse til �".$poem->title."�! <BR><BR>En mail er automatisk sendt til $MAILTAINER_EMAIL, som vil kigge p� sagen.</SMALL>\n";
    } else {
        my $longdid = $poem->longdid;
	$HTML .= "<SMALL>Fandt du en trykfejl i denne tekst, skriv da rettelsen i feltet herunder, og tryk Send</SMALL><BR><BR>";
	$HTML .= '<FORM><TEXTAREA NAME="korrektur" WRAP="virtual" COLS=14 ROWS=4></TEXTAREA><BR>';
	$HTML .= qq|<INPUT TYPE="hidden" NAME="longdid" VALUE="$longdid">|;
	$HTML .= '<INPUT TYPE="submit" VALUE="Send"> ';
	$HTML .= Kalliope::Help->new('korrektur')->linkAsHTML;
	$HTML .= "</FORM>";
    }
    return $HTML;
}

sub notes {
    my ($poem,@keywords) = @_;
    my $HTML;

    if ($poem->notes) {
	foreach my $line (split /\n/,$poem->notes) {
	    $HTML .= '<IMG ALIGN="left" SRC="gfx/clip.gif" BORDER=0 ALT="Note til �'.$poem->title.'�">';
	    Kalliope::buildhrefs(\$line);
	    $HTML .= $line;
	    $HTML .= "<BR><BR>";
	};
    }
    if ($#keywords >= 0) {
	$HTML .= '<B>N�gleord:</B> ';
        $HTML .= join ', ', map { $_->clickableTitle($LA) } @keywords;
    }
    $HTML .= "<BR>";
    return $HTML;
}
