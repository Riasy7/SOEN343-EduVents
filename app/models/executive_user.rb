class ExecutiveUser < User
  belongs_to :organization, optional: false
end
