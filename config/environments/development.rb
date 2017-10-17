Rails.application.configure do
  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true

  config.cache_store = :null_store

  config.action_controller.perform_caching = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.action_view.raise_on_missing_translations = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
