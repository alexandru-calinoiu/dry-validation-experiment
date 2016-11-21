require 'dry-validation'

input_data = {
  name: 'John Doe',
  phone_number: 12345
}

UserContractSchema = Dry::Validation.Schema do
  required(:name).filled
  required(:phone_number).filled
end

result = UserContractSchema.call(input_data)
p result.success?
p result.failure?
p result.errors
