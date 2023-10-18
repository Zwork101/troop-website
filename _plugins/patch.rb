# frozen_string_literal: true
require "down"

module Jekyll

  module StrapiImageFilter
    def asset_url(input)
      # Sometimes to make this output visible in tests debug must be change for info
      # Need to find switch of logging level during rake test TODO: <===
      Jekyll.logger.debug "StrapiImageFilter 000 input:" " ==> YES"
      Jekyll.logger.debug "StrapiImageFilter 111 input:" "#{input}"
      Jekyll.logger.debug "StrapiImageFilter 222 context REGISTERS:" "#{@context.registers}"
      strapi_endpoint = @context.registers[:site].config['strapi']['endpoint']
      Jekyll.logger.debug "StrapiImageFilter strapi_endpoint:" "#{strapi_endpoint}"

      uri_path = "#{strapi_endpoint}#{input['url']}"
      if not Dir.exist?('_tmp_assets')
        # TODO: Check if there is not ability to overwrite from the _config
        Jekyll.logger.info "_tmp_assets directory does not exist, I am going to create one"
        Dir.mkdir '_tmp_assets'
      end
      ##
      # TODO: Investigate if there is a better way to download binaries
      # Check if we need authenticate to get medias
      if not Dir.exist?("_tmp_assets/#{input['name']}")
        Down.download(uri_path, destination: "_tmp_assets/#{input['name']}")

        site = Jekyll.sites.first
        site.static_files << StrapiStaticFile.new(site, site.source, "_tmp_assets", "#{input['name']}")
        "/assets/#{input['name']}"
      end
      ##
      # To perform copying of the assets in the cycle of Jenkins
      # https://jekyllrb.com/docs/rendering-process/

    end
  end
end
Liquid::Template.register_filter(Jekyll::StrapiImageFilter)
