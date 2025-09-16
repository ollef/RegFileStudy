import apfloat;

type F64 = apfloat::APFloat<u32:11, u32:53>;

fn fp64mul(a: F64, b: F64) -> F64 {
  apfloat::mul(a, b)
}
