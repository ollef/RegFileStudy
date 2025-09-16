import chisel3._
import chisel3.util._

class XLSFloatingPointMultiplier(config: MultiplierConfig) extends Module {
  override def desiredName = config.top

  val io = IO(new Bundle {
    val a = Input(UInt(config.width.W))
    val b = Input(UInt(config.width.W))
    val out = Output(UInt(config.width.W))
  })

  if (config.latency == 0) {
    val core = Module(new XLSCombinationalFloatingPointMultiplierCore(config))
    core.io.a := RegNext(io.a)
    core.io.b := RegNext(io.b)
    io.out := RegNext(core.io.out)
  } else {
    val core = Module(new XLSFloatingPointMultiplierCore(config))
    core.io.clk := clock
    core.io.a := RegNext(io.a)
    core.io.b := RegNext(io.b)
    io.out := RegNext(core.io.out)
  }
}

class XLSCombinationalFloatingPointMultiplierCore(config: MultiplierConfig)
    extends BlackBox {
  override def desiredName = config.top + "_core"
  val io = IO(new Bundle {
    val a = Input(UInt(config.width.W))
    val b = Input(UInt(config.width.W))
    val out = Output(UInt(config.width.W))
  })
}

class XLSFloatingPointMultiplierCore(config: MultiplierConfig)
    extends BlackBox {
  override def desiredName = config.top + "_core"
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val a = Input(UInt(config.width.W))
    val b = Input(UInt(config.width.W))
    val out = Output(UInt(config.width.W))
  })
}
