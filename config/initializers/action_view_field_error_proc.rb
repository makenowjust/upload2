# frozen_string_literal: true

Rails.application.config.action_view.field_error_proc = ->(html_tag, instance) do
  if instance.is_a?(ActionView::Helpers::Tags::Label)
    html_tag
  else
    Nokogiri::HTML
      .fragment(html_tag)
      .search('input', 'textarea', 'select')
      .add_class('invalid')
      .to_html.html_safe # rubocop:disable Rails/OutputSafety
  end
end
