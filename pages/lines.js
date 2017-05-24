// @flow

import React from 'react';
import Link from 'next/link';
import Head from '../components/head';
import Nav from '../components/nav';
import Heading from '../components/heading.js';
import PoetName from '../components/poetname.js';
import WorkName from '../components/workname.js';
import Tabs from '../components/tabs.js';
import SectionedList from '../components/sectionedlist.js';
import * as Links from '../components/links.js';
import * as Sorting from './helpers/sorting.js';
import type {
  LinesPair,
  Section,
  Lang,
  Poet,
  Work,
  SectionForRendering,
} from './helpers/types.js';
import 'isomorphic-fetch';

type LinesType = 'first' | 'titles';
export default class extends React.Component {
  props: {
    lang: Lang,
    poet: Poet,
    lines: Array<LinesPair>,
    type: LinesType,
  };

  static async getInitialProps({
    query: { lang, poetId, type },
  }: {
    query: { lang: Lang, poetId: string, type: LinesType },
  }) {
    const res = await fetch(
      `http://localhost:3000/static/api/${poetId}/lines.json`
    );
    const json: { poet: Poet, lines: Array<LinesPair> } = await res.json();
    return { lang, poet: json.poet, lines: json.lines, type };
  }

  groupLines(lines: Array<LinesPair>): Array<Section<LinesPair>> {
    let groups: Map<string, Array<LinesPair>> = new Map();
    lines.forEach(linePair => {
      const line = this.props.type === 'titles'
        ? linePair.title
        : linePair.firstline;
      if (line == null || line.length == 0) {
        return;
      }
      linePair['sortBy'] = line;
      let letter: string = line[0];
      if (line.startsWith('Aa')) {
        letter = 'Å';
      }
      let array = groups.get(letter) || [];
      array.push(linePair);
      groups.set(letter, array);
    });
    let sortedGroups = [];
    groups.forEach((group, key) => {
      sortedGroups.push({
        title: key,
        items: group.sort(Sorting.linesPairsByLine),
      });
    });
    return sortedGroups.sort(Sorting.sectionsByTitle);
  }

  render() {
    const { lang, poet, type, lines } = this.props;

    const tabs = [
      { title: 'Værker', url: Links.worksURL(lang, poet.id) },
      { title: 'Digttitler', url: Links.linesURL(lang, poet.id, 'titles') },
      { title: 'Førstelinjer', url: Links.linesURL(lang, poet.id, 'first') },
    ];
    const selectedTabIndex = type === 'titles' ? 1 : 2;

    const groups = this.groupLines(lines);
    let sections: Array<SectionForRendering> = [];
    groups.forEach(group => {
      const items = group.items.map(lines => {
        const url = Links.textURL(lang, poet.id, lines.id);
        const line = lines[type === 'titles' ? 'title' : 'firstline'];
        return {
          id: lines.id,
          url: url,
          html: <span>{line}</span>,
        };
      });
      sections.push({ title: group.title, items });
    });
    let renderedGroups = <SectionedList sections={sections} />;

    const title = <PoetName poet={poet} includePeriod />;
    return (
      <div>
        <Head title="Digtere - Kalliope" />
        <Nav lang={lang} />

        <div className="row">
          <Heading title={title} />
          <Tabs items={tabs} selectedIndex={selectedTabIndex} />
          {renderedGroups}
        </div>
      </div>
    );
  }
}
