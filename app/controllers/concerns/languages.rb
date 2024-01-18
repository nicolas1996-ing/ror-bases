module Languages 
    extend ActiveSupport::Concern

    included do
        # detectar idioma del navegador
        around_action :switch_locale

        private 
        def switch_locale
            locale = params[:locale] || I18n.default_locale
            I18n.with_locale(locale) do
                yield
            end
        end
    end
end