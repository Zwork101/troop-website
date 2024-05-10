module.exports = ({ env }) => ({
    'website-builder': {
      enabled: true,
      config: {
        builds: [
          {
            url: `http://${env("JEKYLL_SERVER", "0.0.0.0")}:9090`,
            name: 'Production',
            trigger: {
              type: 'manual'
            },
          },
        ],
      },
    },
  });