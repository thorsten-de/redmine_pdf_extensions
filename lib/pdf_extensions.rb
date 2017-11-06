require 'patches/pdf_attach_for_external_files'
require 'patches/pdf_qr_code_for_issue'
module PdfExtensions
  def self.apply_patches()
    Redmine::Export::PDF::RDMPdfEncoding.singleton_class.prepend Patches::PdfAttachForExternalFiles
    Redmine::Export::PDF::IssuesPdfHelper.include Patches::PdfQrCodeForIssue
  end
end
