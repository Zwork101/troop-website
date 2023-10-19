'use strict';

/**
 * eagle service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::eagle.eagle');
