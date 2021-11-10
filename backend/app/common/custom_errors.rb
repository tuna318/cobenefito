module CustomErrors
  class Unauthorized < StandardError
  end

  class RecordExisted < StandardError
  end
end
