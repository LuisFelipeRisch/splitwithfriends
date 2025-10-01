class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    unless value.to_s =~ EMAIL_REGEX
      record.errors.add(attribute, :invalid_email)
    end
  end
end
