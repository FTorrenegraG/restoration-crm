# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_attribute_name(attr, options = {})
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{attr}", default: attr.to_s.humanize)
  end
end
