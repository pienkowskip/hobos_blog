class Asset < ActiveRecord::Base

  hobo_model # Don't put anything above this

  has_attached_file :asset,
                    path: ':rails_root/public/files/:updated_at_path/:basename-:style.:extension',
                    url: '/files/:updated_at_path/:basename-:style.:extension',
                    styles: ->(attachment) do
                      if attachment.content_type =~ /\Aimage\//
                        {large: '1024x768>', medium: '640x480', small: '100x100>', thumb: '100x100#'}
                      elsif attachment.content_type == 'application/pdf'
                        {medium: ['640x480', :png], small: ['100x100>', :png], thumb: ['100x100#', :png]}
                      else
                        {}
                      end
                    end,
                    content_type: %w(image/jpeg image/gif image/png application/pdf),
                    filename_cleaner: Paperclip::TransliterateFilenameCleaner.new(Paperclip::Attachment.default_options[:restricted_characters]),
                    use_timestamp: false

  has_many :posts, foreign_key: 'picture_id', dependent: :restrict_with_exception, inverse_of: :picture

  validates_attachment_file_name :asset, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/]
  validate :validate_asset_file_name

  default_scope -> { order(asset_updated_at: :desc) }
  scope :for_month, ->(date) { where(asset_updated_at: date.utc.beginning_of_month..date.utc.end_of_month) }

  Paperclip.interpolates :updated_at_path do |attachment, _|
    attachment.instance.asset_updated_at_path
  end

  fields do
    timestamps
  end
  attr_accessible :asset

  def asset_updated_at_path
    asset_updated_at.utc.strftime('%Y/%d')
  end

  def name
    asset_updated_at_path + '/' + asset_file_name
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

  private

  def validate_asset_file_name
    asset_file_basename = File.basename(asset_file_name, File.extname(asset_file_name)).downcase
    Asset.for_month(asset_updated_at).where.not(id: id).pluck(:asset_file_name).each do |fname|
      if asset_file_basename == File.basename(fname, File.extname(fname)).downcase
        errors.add(:asset_file_name, :taken)
        break
      end
    end
  end
end
