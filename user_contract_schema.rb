require 'dry-validation'

input_data = {
  name: 'John Doe',
  phone_number: 12345,
  age: 17
}

UserContractSchema = Dry::Validation.Schema do
  required(:name).filled
  required(:phone_number).filled
  required(:age) { filled? & int? & gt?(18) }
end

result = UserContractSchema.call(input_data)
p result.success?
p result.failure?
p result.errors
