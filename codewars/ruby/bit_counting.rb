def count_bits(x)
  def count_bits_impl(x,y)
    (x==0) ? y : count_bits_impl(x>>1,y+(x&1==1?1:0))
  end
  count_bits_impl(x,0)
end

