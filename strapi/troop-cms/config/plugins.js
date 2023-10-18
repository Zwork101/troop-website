module.exports = ({ env }) => ({
    'website-builder': {
      enabled: true,
      config: {
        builds: [
          {
            url: 'http://localhost:9090',
            name: 'Production',
            trigger: {
              type: 'manual'
            },
          },
        ],
      },
    },
  });