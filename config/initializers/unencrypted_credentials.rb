# frozen_string_literal: true

# Честно украдено с тикетки
# Не шифруем credentials вне прода
app = Rails.application
credentials_is_available = !app.config.send(:credentials_available_for_current_env?)
if !Rails.env.production? && credentials_is_available
  content_of_credentials = Rails.root.join('config/credentials/credentials.yml').read
  yaml_credentials = YAML.load(content_of_credentials).deep_symbolize_keys

  # Иницилизация ключей для шифрования происходит до общей иницилизации, поэтому нужно их вручную прописать
  active_record_encryption = yaml_credentials[:active_record_encryption]
  primary_key = active_record_encryption[:primary_key]
  deterministic_key = active_record_encryption[:deterministic_key]
  key_derivation_salt = active_record_encryption[:key_derivation_salt]
  ActiveRecord::Encryption.configure(primary_key:, deterministic_key:, key_derivation_salt:)

  active_support_options = ActiveSupport::InheritableOptions.new(yaml_credentials)
  app.instance_variable_set(:@credentials, active_support_options)
  app.instance_variable_set(:@secrets, active_support_options)
end
