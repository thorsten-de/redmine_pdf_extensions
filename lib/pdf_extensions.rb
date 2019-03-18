require 'patches/pdf_attach_for_external_files'
require 'patches/pdf_display_external_images.rb'
require 'patches/pdf_evaluate_image_size.rb'
require 'patches/pdf_qr_code_for_issue'

module PdfExtensions
  def self.apply_patches()
    Redmine::Export::PDF::RDMPdfEncoding.singleton_class.prepend Patches::PdfAttachForExternalFiles
    Redmine::Export::PDF::ITCPDF.prepend Patches::PdfEvaluateImageSize
    Redmine::Export::PDF::ITCPDF.prepend Patches::PdfDisplayExternalImages
    IssuesHelper.include Patches::PdfQrCodeForIssue
  end
end
