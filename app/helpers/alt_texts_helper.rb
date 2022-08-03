module AltTextsHelper
    def alt_text_history(alt_text)
        alt_text.alt.alt_texts.each do |alt_text|
            link_to "Show this alt text", alt_text
        end
    end

     def resource_name
        :alt_text
    end

    def resource
        @resource ||= AltText.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:alt_text]
    end
      
end
