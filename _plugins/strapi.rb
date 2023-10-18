module Jekyll
  module Strapi
    class StrapiCollection
      def custom_path_params
        "&populate=*"
      end
    end
  end
end
