# frozen_string_literal: true

module FileInfoConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_file_info, only: %i[show destroy]
  end

  private def set_file_info
    @file_info = FileInfo.find_by_hashid!(params[:id])
    if @file_info.outdated?
      raise ActiveRecord::RecordNotFound, "#{params[:id]} is outdated"
    end
  end
end
