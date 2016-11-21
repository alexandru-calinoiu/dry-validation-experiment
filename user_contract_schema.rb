require 'dry-validation'

input_data = {
  name: 'John Doe',
  phone_number: 12345,
  age: 17,
  address: {
    street: 'Viapar Kendra',
    city: nil,
    emails: ['test@test.com', 'invalid']
  }
}

AddressSchema = Dry::Validation.Schema do
  configure do
    def email?(value)
      ! /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]/i.match(value).nil?
    end
  end
  required(:street) { filled? }
  optional(:city)
  optional(:emails).each(:email?)
end

UserContractSchema = Dry::Validation.Schema do
  required(:name).filled
  required(:phone_number).filled
  required(:age) { none? | (filled? & int? & gt?(18)) }
  required(:address).schema(AddressSchema)
end

result = UserContractSchema.call(input_data)
p result.success?
p result.failure?
p result.errors
