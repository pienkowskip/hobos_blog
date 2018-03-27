if Rails.env.development?
  WebConsole::View.class_eval do
    include HoboTranslationsNormalizerHelper
  end
end