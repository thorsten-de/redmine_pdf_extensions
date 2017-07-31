require 'pdf_extensions'

Redmine::Plugin.register :pdf_extensions do
  name 'Pdf Extensions'
  author 'Thorsten Deinert'
  description 'Extend redmines internal pdf generation feature.'
  version '0.0.1'
  url 'https://github.com/thorsten-de/...'
  author_url 'https/github.com/thorsten-de'
end


PdfExtensions.apply_patches