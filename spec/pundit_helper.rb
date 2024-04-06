def grant_authorization(record, query, *params)
  policy_klass = get_policy_klass(record)
  if params.present?
    allow_any_instance_of(policy_klass).to receive(query)
      .with(*params)
      .and_return(true)
  else
    allow_any_instance_of(policy_klass)
      .to receive(query)
      .and_return(true)
  end
end

def revoke_authorization(record, query, *params)
  policy_klass = get_policy_klass(record)
  if params.present?
    allow_any_instance_of(policy_klass).to receive(query)
      .with(*params)
      .and_return(false)
  else
    allow_any_instance_of(policy_klass)
      .to receive(query)
      .and_return(false)
  end
end

def get_policy_klass(record)
  if record.is_a? Class
    record
  else
    Pundit::PolicyFinder.new(record).policy!
  end
end
