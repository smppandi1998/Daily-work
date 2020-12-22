/*
  Copyright (c) 2015 Arduino LLC.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#include "delay.h"
#include "Arduino.h"

#ifdef __cplusplus
extern "C" {
#endif

/** Tick Counter united by ms */
static volatile uint32_t _ulTickCount=0 ;

uint32_t millis( void )
{
// todo: ensure no interrupts
  if (__get_PRIMASK())
  {
    if (SCB->ICSR & SCB_ICSR_PENDSTSET_Msk)
    {
      SCB->ICSR = SCB_ICSR_PENDSTCLR_Msk; // clear interrupt
      ++_ulTickCount;
    }
  }
  return _ulTickCount ;
}

// atomically add delta to _ulTickCount. Momentarily disables interrupts, assuming that
// the systick interrupt is maskable.
uint32_t adjust_millis_forward(uint32_t delta)
{
  // copy old interrupt-enable state to flags.
  uint32_t const flags = __get_PRIMASK();

  // disable interrupts
  __set_PRIMASK(1);

  // observe _ulTickCount, and advance it.
  uint32_t const tickCount = _ulTickCount + delta;

  // save _ulTickCount
  _ulTickCount = tickCount;

  // restore interrupts (does nothing if ints were disabled on entry)
  __set_PRIMASK(flags);

  // return the new value of _ulTickCount.
  return tickCount;
}

// Interrupt-compatible version of micros
// Theory: repeatedly take readings of SysTick counter, millis counter and SysTick interrupt pending flag.
// When it appears that millis counter and pending is stable and SysTick hasn't rolled over, use these
// values to calculate micros. If there is a pending SysTick, add one to the millis counter in the calculation.
uint32_t micros( void )
{
  uint32_t ticks, ticks2;
  uint32_t pend, pend2;
  uint32_t count, count2;

  ticks2  = SysTick->VAL;
  pend2   = !!(SCB->ICSR & SCB_ICSR_PENDSTSET_Msk)  ;
  count2  = millis() ;

  do
  {
    ticks=ticks2;
    pend=pend2;
    count=count2;
    ticks2  = SysTick->VAL;
    pend2   = !!(SCB->ICSR & SCB_ICSR_PENDSTSET_Msk)  ;
    count2  = millis() ;
  } while ((pend != pend2) || (count != count2) || (ticks < ticks2));

  return ((count+pend) * 1000) + (((SysTick->LOAD  - ticks)*(1048576/(VARIANT_MCK/1000000)))>>20) ;
  // this is an optimization to turn a runtime division into two compile-time divisions and
  // a runtime multiplication and shift, saving a few cycles
}

void delay( uint32_t ms )
{
  if ( ms == 0 )
  {
    return ;
  }

  uint32_t start = millis() ;

  do
  {
    yield() ;
  } while ( millis() - start < ms ) ;
}

#include "Reset.h" // for tickReset()

void SysTick_DefaultHandler(void)
{
  // Increment tick count each ms
  _ulTickCount++;
  tickReset();
}

#ifdef __cplusplus
}
#endif
