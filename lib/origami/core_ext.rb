class Bignum #:nodoc:
  def to_o
    Origami::Integer.new(self)
  end
end

class Fixnum #:nodoc:
  def to_o
    Origami::Integer.new(self)
  end
end

class Array #:nodoc:
  def to_o
    Origami::Array.new(self)
  end
end

class Float #:nodoc:
  def to_o
    Origami::Real.new(self)
  end
end

class Hash #:nodoc:
  def to_o
    Origami::Dictionary.new(self)
  end
end

class TrueClass #:nodoc:
  def to_o
    Origami::Boolean.new(true)
  end
end

class FalseClass #:nodoc:
  def to_o
    Origami::Boolean.new(false)
  end
end

class NilClass #:nodoc:
  def to_o
    Origami::Null.new
  end
end

class Symbol #:nodoc:
  def to_o
    Origami::Name.new(self)
  end
end

class String #:nodoc:
  def to_o
    Origami::ByteString.new(self)
  end
end
