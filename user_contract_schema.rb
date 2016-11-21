require 'dry-validation'

input_data = {
  name: 'John Doe',
  phone_number: 12345,
  age: 17,
  address: {
    street: 'Viapar Kendra',
    city: nil
  }
}

UserContractSchema = Dry::Validation.Schema do
  required(:name).filled
  required(:phone_number).filled
  required(:age) { none? | (filled? & int? & gt?(18)) }
  required(:address).schema do
    required(:street) { filled? }
    optional(:city)
  end
end

result = UserContractSchema.call(input_data)
p result.success?
p result.failure?
p result.errors
