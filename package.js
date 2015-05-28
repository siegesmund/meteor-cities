Package.describe({

  name: 'peter:cities',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Creates and manages daily updates for a geonames.org city database',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/siegesmund/meteor-geocities.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  api.use(['coffeescript', 'mongo', 'http']);
  api.use(['meteorhacks:npm@1.3.0', 'percolate:synced-cron@1.2.1']);
  api.addFiles(['geonames.coffee', 'cron.coffee']);
  api.export(['GeoNames'], ['client', 'server']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('underscore');
  api.use('peter:cities');
  api.addFiles('geo-tests.js');
  api.export(['GeoNames'], ['client', 'server']);
});

Npm.depends({
  jszip: '2.5.0',
  request: '2.55.0'
});
