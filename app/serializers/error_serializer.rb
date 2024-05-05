class ErrorSerializer
  def self.serialize_error(exception)
    {
      errors: [
          {
            detail: exception.message
          }
        ]
      }
  end
end