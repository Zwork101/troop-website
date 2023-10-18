import type { Schema, Attribute } from '@strapi/strapi';

export interface EventsTags extends Schema.Component {
  collectionName: 'components_events_tags';
  info: {
    displayName: 'tags';
    icon: 'priceTag';
  };
  attributes: {
    name: Attribute.String;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'events.tags': EventsTags;
    }
  }
}
