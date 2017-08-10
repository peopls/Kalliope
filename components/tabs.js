// @flow
import React from 'react';
import { Link, Router } from '../routes';
import * as Links from './links.js';
import { poetGenetiveLastName } from './poetname.js';
import type { Lang, Poet, Country } from '../pages/helpers/types.js';
import CommonData from '../pages/helpers/commondata.js';

class LoupeSVG extends React.Component {
  props: {
    color: string,
  };
  render() {
    const { color } = this.props;
    const style = {
      fill: 'none',
      stroke: color,
      strokeLinecap: 'round',
      strokeLinejoin: 'round',
      strokeWidth: '2px',
    };
    return (
      <svg viewBox="0 -5 48 53" width="100%" height="100%">
        <ellipse style={style} cx="19.55" cy="19.5" rx="18.55" ry="18.5" />
        <line style={style} x1="47" x2="32.96" y1="47" y2="33" />
      </svg>
    );
  }
}

class CrossSVG extends React.Component {
  props: {
    color: string,
  };
  render() {
    const { color } = this.props;
    const style = {
      fill: 'none',
      stroke: color,
      strokeLinecap: 'round',
      strokeLinejoin: 'round',
      strokeWidth: '2px',
    };
    return (
      <svg viewBox="0 0 48 48" width="100%" height="100%">
        <line
          style={style}
          x1="47"
          y1="47"
          x2="4"
          y2="4"
          vector-effect="non-scaling-stroke"
        />
        <line
          style={style}
          x1="47"
          y1="4"
          x2="4"
          y2="47"
          vector-effect="non-scaling-stroke"
        />
      </svg>
    );
  }
}

export default class Tabs extends React.Component {
  props: {
    items: Array<{ id: string, url: string, title: string, hide?: boolean }>,
    poet?: Poet,
    country: Country,
    lang: Lang,
    query?: ?string,
    selected: string,
  };
  searchField: HTMLInputElement;
  onLoupeClick: (e: Event) => void;
  onCrossClick: (e: Event) => void;
  onSubmit: (e: Event) => void;
  onKeyDown: (e: KeyboardEvent) => void;

  constructor(props: any) {
    super(props);
    const { query } = props;
    this.state = { showSearchField: query != null && query.length > 0 };
    this.onLoupeClick = this.onLoupeClick.bind(this);
    this.onCrossClick = this.onCrossClick.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.onKeyDown = this.onKeyDown.bind(this);
  }

  hideSearchField() {
    this.searchField.value = '';
    if (window) {
      window.removeEventListener('keydown', this.onKeyDown);
    }
    this.setState({ showSearchField: false });
  }

  componentDidUpdate() {
    if (this.state.showSearchField) {
      if (window) {
        window.addEventListener('keydown', this.onKeyDown);
      }
      if (document && document.activeElement !== this.searchField) {
        this.searchField.focus();
      }
    }
  }

  showSeachField() {
    this.setState({ showSearchField: true });
  }

  onSubmit(e: Event) {
    const q = this.searchField.value;
    const { poet, country, lang } = this.props;
    let URL = null;
    if (poet != null && poet.has_texts) {
      URL = Links.searchURL(lang, q, poet.country, poet.id);
    } else {
      URL = Links.searchURL(lang, q, country);
    }
    if (document) {
      this.searchField.blur();
    }
    Router.pushRoute(URL);
    e.preventDefault();
  }

  onLoupeClick(e: Event) {
    if (this.state.showSearchField) {
      const q = this.searchField.value;
      if (q.length === 0) {
        // When the text input is empty, the loupe
        // should simply toggle seach mode.
        this.hideSearchField();
      } else {
        this.onSubmit(e);
      }
    } else {
      this.showSeachField();
    }
    e.preventDefault();
  }

  onCrossClick(e: MouseEvent) {
    this.hideSearchField();
    e.preventDefault();
  }

  onKeyDown(e: KeyboardEvent) {
    if (e.keyCode === 27) {
      this.hideSearchField();
      e.preventDefault();
    }
  }

  render() {
    const { items, selected, poet, country, lang, query } = this.props;
    let placeholder = null;
    if (poet != null && poet.has_texts) {
      const genetiveLastName = poetGenetiveLastName(poet, lang);
      placeholder = `Søg i ${genetiveLastName} værker`;
    } else {
      if (country === 'dk') {
        placeholder = `Søg i Kalliope`;
      } else {
        const countryData = CommonData.countries.filter(
          x => x.code === country
        );
        if (countryData.length > 0) {
          const adjective = countryData[0].adjective[lang];
          placeholder = `Søg i Kalliopes ${adjective} samling`;
        } else {
          placeholder = `Søg i Kalliope`;
        }
      }
    }
    const searchField = (
      <div style={{ display: 'flex' }}>
        <div style={{ flexGrow: 1 }}>
          <form onSubmit={this.onSubmit}>
            <input
              ref={domElement => {
                this.searchField = domElement;
              }}
              defaultValue={query}
              className="search-field"
              placeholder={placeholder}
            />
          </form>
        </div>
        <div
          onClick={this.onCrossClick}
          style={{
            cursor: 'pointer',
            flexBasis: '28px',
            flexShrink: 1,
            marginTop: '12px',
            marginRight: '20px',
            marginLeft: '20px',
          }}>
          <CrossSVG color="black" />
        </div>
      </div>
    );

    const itemsRendered = items.filter(item => !item.hide).map((item, i) => {
      const className = item.id === selected ? 'tab selected' : 'tab';
      return (
        <div className={className} key={item.url}>
          <Link route={item.url}>
            <a>
              <h2>
                {item.title}
              </h2>
            </a>
          </Link>
        </div>
      );
    });

    const leftSide = (
      <div className="leftside">
        <div
          className="tabs"
          style={{
            display: this.state.showSearchField ? 'none' : 'block',
          }}>
          {itemsRendered}
        </div>
        <div
          className="searchfield-container"
          style={{
            display: this.state.showSearchField ? 'block' : 'none',
          }}>
          {searchField}
        </div>
      </div>
    );

    const loupeColor = this.state.showSearchField ? 'black' : '#707070';

    return (
      <div className="tabs-container">
        {leftSide}
        <div className="loupe" style={{ alignSelf: 'flex-start' }}>
          <span onClick={this.onLoupeClick} style={{ cursor: 'pointer' }}>
            <LoupeSVG color={loupeColor} />
          </span>
        </div>
        <style jsx>{`
          .tabs-container {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid black;
            margin-bottom: 40px;
            margin-top: 30px;
            flex-grow: 1;
          }
          :global(.loupe) {
            flex-basis: 32px;
            flex-shrink: 1;
            align-self: flex-start;
          }
          :global(.leftside) {
            width: 100%;
            padding-right: 10px;
          }
          :global(.search-field) {
            font-size: 32px;
            line-height: 32px;
            width: 100%;
            border: 0;
            padding: 0;
            margin: 0;
            outline: 0;
            font-weight: lighter;
            font-family: inherit;
          }
          :global(.searchfield-container) {
            width: 100%;
            padding-bottom: 11px;
          }
          .tabs {
            background-color: yellow;
          }
          :global(.tabs) > :global(.tab) {
            display: inline-block;
            margin-right: 40px;
            border-bottom: 2px solid transparent;
            padding-bottom: 20px;
          }
          :global(.tabs) > :global(.tab) :global(h2) {
            margin: 0;
            padding: 0;
            line-height: 32px;
            font-size: 32px;
            font-weight: lighter;
          }
          :global(.tabs) > :global(.tab.selected) {
            border-bottom: 2px solid black;
          }
          :global(.tabs) :global(.tab.selected a) {
            color: black;
          }
          :global(.tabs) > :global(.tab) :global(a) {
            color: #707070;
          }
          @media (max-width: 321px) {
            .tabs > :global(.tab) {
              margin-right: 4px !important;
            }
          }
          @media (max-width: 480px) {
            :global(.tabs) > :global(.tab) {
              margin-right: 10px;
            }
            :global(.tabs) > :global(.tab) :global(h2) {
              font-size: 12px !important;
              line-height: 12px;
            }
            :global(.loupe) {
              flex-basis: 12px;
            }
            :global(.search-field) {
              font-size: 12px;
              line-height: 12px;
            }
          }
          @media (max-width: 800px) {
            :global(.tabs) > :global(.tab) :global(h2) {
              font-size: 28px;
              line-height: 28px;
            }
            :global(.loupe) {
              flex-basis: 28px;
            }
            :global(.tabs) > :global(.tab) {
              margin-right: 20px;
            }
            :global(.search-field) {
              font-size: 28px;
              line-height: 28px;
            }
          }
          @media (max-width: 700px) {
            :global(.tabs) > :global(.tab) :global(h2) {
              font-size: 24px;
              line-height: 24px;
            }
            :global(.loupe) {
              flex-basis: 24px;
            }
            :global(.tabs) > :global(.tab) {
              margin-right: 15px;
            }
            :global(.search-field) {
              font-size: 24px;
              line-height: 24px;
            }
          }
          @media (max-width: 600px) {
            :global(.tabs) > :global(.tab) :global(h2) {
              font-size: 18px;
              line-height: 18px;
            }
            :global(.loupe) {
              flex-basis: 18px;
            }
            :global(.tabs) > :global(.tab) {
              margin-right: 15px;
            }
            :global(.search-field) {
              font-size: 18px;
              line-height: 18px;
            }
          }
          @media print {
            .tabs-container {
              display: none;
            }
          }
        `}</style>
      </div>
    );
  }
}

export class PoetTabs extends React.Component {
  props: {
    poet: Poet,
    lang: Lang,
    query?: ?string,
    selected: 'works' | 'titles' | 'first' | 'bio' | 'bibliography' | 'search',
  };

  render() {
    const { lang, poet, selected, query } = this.props;
    const tabs: Array<{
      id: string,
      title: string,
      hide?: boolean,
      url: string,
    }> = [
      {
        id: 'works',
        title: 'Værker',
        hide: !poet.has_works,
        url: Links.worksURL(lang, poet.id),
      },
      {
        id: 'titles',
        title: 'Digttitler',
        hide: !poet.has_poems,
        url: Links.textsURL(lang, poet.id, 'titles'),
      },
      {
        id: 'first',
        title: 'Førstelinjer',
        hide: !poet.has_poems,
        url: Links.textsURL(lang, poet.id, 'first'),
      },
      {
        id: 'bibliography',
        title: 'Bibliografi',
        hide: !poet.has_bibliography,
        url: Links.bibliographyURL(lang, poet.id),
      },
      {
        id: 'bio',
        title: 'Biografi',
        hide: !poet.has_biography,
        url: Links.bioURL(lang, poet.id),
      },
    ];
    return (
      <Tabs
        items={tabs}
        selected={selected}
        lang={lang}
        country={poet.country}
        poet={poet}
        query={query}
      />
    );
  }
}

export class KalliopeTabs extends React.Component {
  props: {
    lang: Lang,
    country?: Country,
    query?: ?string,
    selected:
      | 'index'
      | 'poets'
      | 'keywords'
      | 'dictionary'
      | 'about'
      | 'search',
  };
  render() {
    const { lang, selected, country, query } = this.props;
    const tabs = [
      { id: 'index', title: 'Kalliope', url: Links.frontPageURL(lang) },
      { id: 'poets', title: 'Digtere', url: Links.poetsURL(lang, 'name') },
      { id: 'keywords', title: 'Nøgleord', url: Links.keywordsURL(lang) },
      { id: 'dictionary', title: 'Ordbog', url: Links.dictionaryURL(lang) },
      { id: 'about', title: 'Om', url: Links.aboutURL(lang, 'kalliope') },
    ];
    return (
      <Tabs
        items={tabs}
        selected={selected}
        lang={lang}
        country={country || 'dk'}
        query={query}
      />
    );
  }
}
