'use strict';

/**
 * troop-leader service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::troop-leader.troop-leader');
