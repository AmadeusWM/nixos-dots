const CONFIG = new Config({
  disabled: [],
  openLastVisitedTab: false,
  tabs: [
    {
      name: 'home',
      background_url: 'src/img/banners/cbg-7.gif',
      categories: [{
        name: 'dev',
        links: [
          {
            name: '/gh/',
            url: 'https://github.com/',
            icon: 'brand-github'
          },
          {
            name: '/gt/',
            url: 'https://git.familymoyaers.com/',
            icon: 'coffee',
            icon_color: '#64876d'
          },
          {
            name: '/nextcl/',
            url: 'https://nextcloud.familymoyaers.com/apps/files/?dir=/&fileid=7551',
            icon: 'brand-nextcloud',
            icon_color: '#4F7484'
          },
          {
            name: '/bb/',
            url: 'https://bb.uhasselt.be',
            icon: 'school',
            icon_color: '#8E76B0'
          },
        ]
      },
      {
        name: 'NIX',
        links: [
          {
            name: '/pkgs/',
            url: 'https://search.nixos.org/packages',
            icon: 'packages',
            icon_color: "#3B5167"
          },
          {
            name: '/opt/',
            url: 'https://search.nixos.org/options',
            icon: 'manual-gearbox',
            icon_color: "#71495E"
          },
        ]
      },
      {
        name: 'HM',
        links: [
          {
            name: '/opt/',
            url: 'https://nix-community.github.io/home-manager/options.html',
            icon: "brand-google-home",
            icon_color: "#917E46"
          },
        ]
      }
      ]
    },
    {
      name: 'music',
      background_url: 'src/img/banners/cbg-2.gif',
      categories: [
        {
          name: 'music services',
          links: [
            {
              url: 'https://soundcloud.com/',
              icon: 'brand-soundcloud',
              icon_color: '#c57750'
            },
            {
              url: 'https://youtu.be/',
              icon: 'brand-youtube',
              icon_color: '#996767'
            },
            {
              url: 'https://r-a-d.io/',
              icon: 'radio'
            },
          ]
        },
        {
          name: 'music boards',
          links: [
            {
              name: '/music/',
              url: 'https://lainchan.org/music/',
              icon: 'disc'
            },
            {
              name: '/mu/',
              url: 'https://boards.4channel.org/mu/',
            }
          ]
        }
      ]
    },
    {
      name: 'tech',
      background_url: 'src/img/banners/cbg-3.gif',
      categories: [
        {
          name: 'subreddits',
          links: [
            {
              name: 'r/startpages/',
              url: 'https://www.reddit.com/r/startpages/'
            },
            {
              name: 'r/unixporn',
              url: 'https://www.reddit.com/r/unixporn/'
            },
            {
              name: 'r/mechkbds/',
              url: 'https://www.reddit.com/r/MechanicalKeyboards/',
              icon: 'keyboard',
              icon_color: '#a57685'
            },
            {
              name: 'r/programming',
              url: 'https://www.reddit.com/r/programming/'
            }
          ]
        },
        {
          name: 'blogs',
          links: [
            {
              name: 'fasterthanli',
              url: 'https://fasterthanli.me/articles',
              icon: 'anchor'
            },
            {
              name: 'dev.to',
              url: 'https://dev.to'
            },
            {
              name: 'mataroa.blog',
              url: 'https://collection.mataroa.blog',
            }
          ]
        },
        {
          name: 'misc',
          links: [
            {
              name: 'post office',
              url: 'http://afternoon.dynu.com/letterbox.html',
              icon: 'mailbox'
            },
            {
              name: 'rust docs',
              url: 'https://doc.rust-lang.org/book/',
              icon: 'notebook',
              icon_color: '#977a3a'
            }
          ]
        }
      ]
    }]
});
