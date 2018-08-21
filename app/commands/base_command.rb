# Abstract Class
class BaseCommand
  attr_reader :result

  class << self
    def call(*args)
      new(*args).call
    end
  end

  # Call payload and set the result of token
  def call
    @result = nil
    payload
    self
  end

  # Return true if errors empty
  def success?
    errors.empty?
  end

  # Set the errors from ActiveModel::Errors
  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  # Extend the child class
  # Actually this is abstract method
  def initialize(*_)
    raise NotImplementedError
  end

  # Abstract Method
  def payload
    raise NotImplementedError
  end
end
