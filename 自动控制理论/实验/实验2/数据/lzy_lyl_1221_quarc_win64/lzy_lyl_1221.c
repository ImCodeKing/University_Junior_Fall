/*
 * lzy_lyl_1221.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "lzy_lyl_1221".
 *
 * Model version              : 15.3
 * Simulink Coder version : 9.9 (R2023a) 19-Nov-2022
 * C source code generated on : Thu Dec 21 17:05:31 2023
 *
 * Target selection: quarc_win64.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "lzy_lyl_1221.h"
#include "rtwtypes.h"
#include <math.h>
#include "lzy_lyl_1221_private.h"
#include "rt_nonfinite.h"
#include <float.h>
#include <string.h>
#include "lzy_lyl_1221_dt.h"

/* Block signals (default storage) */
B_lzy_lyl_1221_T lzy_lyl_1221_B;

/* Continuous states */
X_lzy_lyl_1221_T lzy_lyl_1221_X;

/* Block states (default storage) */
DW_lzy_lyl_1221_T lzy_lyl_1221_DW;

/* Real-time model */
static RT_MODEL_lzy_lyl_1221_T lzy_lyl_1221_M_;
RT_MODEL_lzy_lyl_1221_T *const lzy_lyl_1221_M = &lzy_lyl_1221_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  lzy_lyl_1221_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  lzy_lyl_1221_output();
  lzy_lyl_1221_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  lzy_lyl_1221_output();
  lzy_lyl_1221_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

real_T rt_modd_snf(real_T u0, real_T u1)
{
  real_T y;
  y = u0;
  if (u1 == 0.0) {
    if (u0 == 0.0) {
      y = u1;
    }
  } else if (rtIsNaN(u0) || rtIsNaN(u1) || rtIsInf(u0)) {
    y = (rtNaN);
  } else if (u0 == 0.0) {
    y = 0.0 / u1;
  } else if (rtIsInf(u1)) {
    if ((u1 < 0.0) != (u0 < 0.0)) {
      y = u1;
    }
  } else {
    boolean_T yEq;
    y = fmod(u0, u1);
    yEq = (y == 0.0);
    if ((!yEq) && (u1 > floor(u1))) {
      real_T q;
      q = fabs(u0 / u1);
      yEq = !(fabs(q - floor(q + 0.5)) > DBL_EPSILON * q);
    }

    if (yEq) {
      y = u1 * 0.0;
    } else if ((u0 < 0.0) != (u1 < 0.0)) {
      y += u1;
    }
  }

  return y;
}

/* Model output function */
void lzy_lyl_1221_output(void)
{
  real_T rtb_Abs;
  real_T rtb_HILReadEncoderTimebase_o1;
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    /* set solver stop time */
    if (!(lzy_lyl_1221_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&lzy_lyl_1221_M->solverInfo,
                            ((lzy_lyl_1221_M->Timing.clockTickH0 + 1) *
        lzy_lyl_1221_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&lzy_lyl_1221_M->solverInfo,
                            ((lzy_lyl_1221_M->Timing.clockTick0 + 1) *
        lzy_lyl_1221_M->Timing.stepSize0 + lzy_lyl_1221_M->Timing.clockTickH0 *
        lzy_lyl_1221_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(lzy_lyl_1221_M)) {
    lzy_lyl_1221_M->Timing.t[0] = rtsiGetT(&lzy_lyl_1221_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    /* S-Function (hil_read_encoder_timebase_block): '<S7>/HIL Read Encoder Timebase' */

    /* S-Function Block: lzy_lyl_1221/Subsystem/HIL Read Encoder Timebase (hil_read_encoder_timebase_block) */
    {
      t_error result;
      result = hil_task_read_encoder(lzy_lyl_1221_DW.HILReadEncoderTimebase_Task,
        1, &lzy_lyl_1221_DW.HILReadEncoderTimebase_Buffer[0]);
      if (result < 0) {
        rtb_HILReadEncoderTimebase_o1 = 0;
        rtb_Abs = 0;
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      } else {
        rtb_HILReadEncoderTimebase_o1 =
          lzy_lyl_1221_DW.HILReadEncoderTimebase_Buffer[0];
        rtb_Abs = lzy_lyl_1221_DW.HILReadEncoderTimebase_Buffer[1];
      }
    }

    /* Bias: '<S7>/Bias' incorporates:
     *  Constant: '<S7>/Constant1'
     *  Gain: '<S7>/Gain2'
     *  Math: '<S7>/Math Function'
     */
    lzy_lyl_1221_B.Bias = rt_modd_snf(lzy_lyl_1221_P.Gain2_Gain * rtb_Abs,
      lzy_lyl_1221_P.Constant1_Value) + lzy_lyl_1221_P.Bias_Bias;

    /* Abs: '<Root>/Abs' */
    rtb_Abs = fabs(lzy_lyl_1221_B.Bias);

    /* RelationalOperator: '<S1>/Compare' incorporates:
     *  Constant: '<S1>/Constant'
     */
    lzy_lyl_1221_B.Compare = (rtb_Abs <= lzy_lyl_1221_P.CompareToConstant_const);
  }

  /* SignalGenerator: '<Root>/Signal Generator1' */
  rtb_Abs = lzy_lyl_1221_P.SignalGenerator1_Frequency * lzy_lyl_1221_M->
    Timing.t[0];
  if (rtb_Abs - floor(rtb_Abs) >= 0.5) {
    rtb_Abs = lzy_lyl_1221_P.SignalGenerator1_Amplitude;
  } else {
    rtb_Abs = -lzy_lyl_1221_P.SignalGenerator1_Amplitude;
  }

  /* Gain: '<S2>/Gain1' incorporates:
   *  Gain: '<Root>/Gain2'
   *  SignalGenerator: '<Root>/Signal Generator1'
   */
  rtb_Abs = lzy_lyl_1221_P.Gain2_Gain_p * rtb_Abs * lzy_lyl_1221_P.Gain1_Gain;
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    /* Gain: '<S7>/Gain' */
    lzy_lyl_1221_B.Gain = lzy_lyl_1221_P.Gain_Gain_i *
      rtb_HILReadEncoderTimebase_o1;
  }

  /* MultiPortSwitch: '<Root>/Multiport Switch' */
  if (!lzy_lyl_1221_B.Compare) {
    /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
     *  Constant: '<Root>/Constant'
     */
    lzy_lyl_1221_B.MultiportSwitch = lzy_lyl_1221_P.Constant_Value;
  } else {
    /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
     *  Gain: '<Root>/Gain'
     *  Gain: '<Root>/Gain3'
     *  Sum: '<Root>/Sum'
     *  TransferFcn: '<S7>/Transfer Fcn'
     *  TransferFcn: '<S7>/Transfer Fcn1'
     */
    lzy_lyl_1221_B.MultiportSwitch = (((lzy_lyl_1221_P.Gain3_Gain[0] * rtb_Abs -
      lzy_lyl_1221_B.Gain) * lzy_lyl_1221_P.Gain_Gain[0] +
      (lzy_lyl_1221_P.Gain3_Gain[1] * rtb_Abs - lzy_lyl_1221_B.Bias) *
      lzy_lyl_1221_P.Gain_Gain[1]) + (lzy_lyl_1221_P.Gain3_Gain[2] * rtb_Abs -
      (lzy_lyl_1221_P.TransferFcn_C * lzy_lyl_1221_X.TransferFcn_CSTATE +
       lzy_lyl_1221_P.TransferFcn_D * lzy_lyl_1221_B.Gain)) *
      lzy_lyl_1221_P.Gain_Gain[2]) + (lzy_lyl_1221_P.Gain3_Gain[3] * rtb_Abs -
      (lzy_lyl_1221_P.TransferFcn1_C * lzy_lyl_1221_X.TransferFcn1_CSTATE +
       lzy_lyl_1221_P.TransferFcn1_D * lzy_lyl_1221_B.Bias)) *
      lzy_lyl_1221_P.Gain_Gain[3];
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
  }

  /* Gain: '<S5>/Gain' */
  lzy_lyl_1221_B.Gain_m[0] = lzy_lyl_1221_P.Gain_Gain_e * rtb_Abs;
  lzy_lyl_1221_B.Gain_m[1] = lzy_lyl_1221_P.Gain_Gain_e * lzy_lyl_1221_B.Gain;
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    /* Gain: '<S6>/Gain' */
    lzy_lyl_1221_B.Gain_g = lzy_lyl_1221_P.Gain_Gain_h * lzy_lyl_1221_B.Bias;
  }

  /* Saturate: '<Root>/Saturation' */
  if (lzy_lyl_1221_B.MultiportSwitch > lzy_lyl_1221_P.Saturation_UpperSat) {
    rtb_Abs = lzy_lyl_1221_P.Saturation_UpperSat;
  } else if (lzy_lyl_1221_B.MultiportSwitch < lzy_lyl_1221_P.Saturation_LowerSat)
  {
    rtb_Abs = lzy_lyl_1221_P.Saturation_LowerSat;
  } else {
    rtb_Abs = lzy_lyl_1221_B.MultiportSwitch;
  }

  /* Gain: '<S7>/Gain1' incorporates:
   *  Saturate: '<Root>/Saturation'
   */
  lzy_lyl_1221_B.Gain1 = lzy_lyl_1221_P.Gain1_Gain_d * rtb_Abs;
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    /* S-Function (hil_write_analog_block): '<S7>/HIL Write Analog' */

    /* S-Function Block: lzy_lyl_1221/Subsystem/HIL Write Analog (hil_write_analog_block) */
    {
      t_error result;
      result = hil_write_analog(lzy_lyl_1221_DW.HILInitialize_Card,
        &lzy_lyl_1221_P.HILWriteAnalog_channels, 1, &lzy_lyl_1221_B.Gain1);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      }
    }
  }
}

/* Model update function */
void lzy_lyl_1221_update(void)
{
  if (rtmIsMajorTimeStep(lzy_lyl_1221_M)) {
    rt_ertODEUpdateContinuousStates(&lzy_lyl_1221_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++lzy_lyl_1221_M->Timing.clockTick0)) {
    ++lzy_lyl_1221_M->Timing.clockTickH0;
  }

  lzy_lyl_1221_M->Timing.t[0] = rtsiGetSolverStopTime
    (&lzy_lyl_1221_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.002s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++lzy_lyl_1221_M->Timing.clockTick1)) {
      ++lzy_lyl_1221_M->Timing.clockTickH1;
    }

    lzy_lyl_1221_M->Timing.t[1] = lzy_lyl_1221_M->Timing.clockTick1 *
      lzy_lyl_1221_M->Timing.stepSize1 + lzy_lyl_1221_M->Timing.clockTickH1 *
      lzy_lyl_1221_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void lzy_lyl_1221_derivatives(void)
{
  XDot_lzy_lyl_1221_T *_rtXdot;
  _rtXdot = ((XDot_lzy_lyl_1221_T *) lzy_lyl_1221_M->derivs);

  /* Derivatives for TransferFcn: '<S7>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = lzy_lyl_1221_P.TransferFcn_A *
    lzy_lyl_1221_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += lzy_lyl_1221_B.Gain;

  /* Derivatives for TransferFcn: '<S7>/Transfer Fcn1' */
  _rtXdot->TransferFcn1_CSTATE = lzy_lyl_1221_P.TransferFcn1_A *
    lzy_lyl_1221_X.TransferFcn1_CSTATE;
  _rtXdot->TransferFcn1_CSTATE += lzy_lyl_1221_B.Bias;
}

/* Model initialize function */
void lzy_lyl_1221_initialize(void)
{
  /* Start for S-Function (hil_initialize_block): '<Root>/HIL Initialize' */

  /* S-Function Block: lzy_lyl_1221/HIL Initialize (hil_initialize_block) */
  {
    t_int result;
    t_boolean is_switching;
    result = hil_open("qube_servo3_usb", "0",
                      &lzy_lyl_1221_DW.HILInitialize_Card);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      return;
    }

    is_switching = false;
    result = hil_set_card_specific_options(lzy_lyl_1221_DW.HILInitialize_Card,
      "deadband_compensation=0.65;pwm_en=0;enc0_velocity=3.0;enc1_velocity=3.0;",
      73);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      return;
    }

    result = hil_watchdog_clear(lzy_lyl_1221_DW.HILInitialize_Card);
    if (result < 0 && result != -QERR_HIL_WATCHDOG_CLEAR) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      return;
    }

    if ((lzy_lyl_1221_P.HILInitialize_AIPStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_AIPEnter && is_switching)) {
      result = hil_set_analog_input_ranges(lzy_lyl_1221_DW.HILInitialize_Card,
        &lzy_lyl_1221_P.HILInitialize_AIChannels, 1U,
        &lzy_lyl_1221_P.HILInitialize_AILow,
        &lzy_lyl_1221_P.HILInitialize_AIHigh);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if ((lzy_lyl_1221_P.HILInitialize_AOPStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_AOPEnter && is_switching)) {
      result = hil_set_analog_output_ranges(lzy_lyl_1221_DW.HILInitialize_Card,
        &lzy_lyl_1221_P.HILInitialize_AOChannels, 1U,
        &lzy_lyl_1221_P.HILInitialize_AOLow,
        &lzy_lyl_1221_P.HILInitialize_AOHigh);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if ((lzy_lyl_1221_P.HILInitialize_AOStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_AOEnter && is_switching)) {
      result = hil_write_analog(lzy_lyl_1221_DW.HILInitialize_Card,
        &lzy_lyl_1221_P.HILInitialize_AOChannels, 1U,
        &lzy_lyl_1221_P.HILInitialize_AOInitial);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if (lzy_lyl_1221_P.HILInitialize_AOReset) {
      result = hil_watchdog_set_analog_expiration_state
        (lzy_lyl_1221_DW.HILInitialize_Card,
         &lzy_lyl_1221_P.HILInitialize_AOChannels, 1U,
         &lzy_lyl_1221_P.HILInitialize_AOWatchdog);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    result = hil_set_digital_directions(lzy_lyl_1221_DW.HILInitialize_Card, NULL,
      0U, &lzy_lyl_1221_P.HILInitialize_DOChannels, 1U);
    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
      return;
    }

    if ((lzy_lyl_1221_P.HILInitialize_DOStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_DOEnter && is_switching)) {
      result = hil_write_digital(lzy_lyl_1221_DW.HILInitialize_Card,
        &lzy_lyl_1221_P.HILInitialize_DOChannels, 1U, (t_boolean *)
        &lzy_lyl_1221_P.HILInitialize_DOInitial);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if (lzy_lyl_1221_P.HILInitialize_DOReset) {
      result = hil_watchdog_set_digital_expiration_state
        (lzy_lyl_1221_DW.HILInitialize_Card,
         &lzy_lyl_1221_P.HILInitialize_DOChannels, 1U, (const t_digital_state *)
         &lzy_lyl_1221_P.HILInitialize_DOWatchdog);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if ((lzy_lyl_1221_P.HILInitialize_EIPStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_EIPEnter && is_switching)) {
      lzy_lyl_1221_DW.HILInitialize_QuadratureModes[0] =
        lzy_lyl_1221_P.HILInitialize_EIQuadrature;
      lzy_lyl_1221_DW.HILInitialize_QuadratureModes[1] =
        lzy_lyl_1221_P.HILInitialize_EIQuadrature;
      result = hil_set_encoder_quadrature_mode
        (lzy_lyl_1221_DW.HILInitialize_Card,
         lzy_lyl_1221_P.HILInitialize_EIChannels, 2U, (t_encoder_quadrature_mode
          *) &lzy_lyl_1221_DW.HILInitialize_QuadratureModes[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if ((lzy_lyl_1221_P.HILInitialize_EIStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_EIEnter && is_switching)) {
      lzy_lyl_1221_DW.HILInitialize_InitialEICounts[0] =
        lzy_lyl_1221_P.HILInitialize_EIInitial;
      lzy_lyl_1221_DW.HILInitialize_InitialEICounts[1] =
        lzy_lyl_1221_P.HILInitialize_EIInitial;
      result = hil_set_encoder_counts(lzy_lyl_1221_DW.HILInitialize_Card,
        lzy_lyl_1221_P.HILInitialize_EIChannels, 2U,
        &lzy_lyl_1221_DW.HILInitialize_InitialEICounts[0]);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if ((lzy_lyl_1221_P.HILInitialize_OOStart && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_OOEnter && is_switching)) {
      result = hil_write_other(lzy_lyl_1221_DW.HILInitialize_Card,
        lzy_lyl_1221_P.HILInitialize_OOChannels, 3U,
        lzy_lyl_1221_P.HILInitialize_OOInitial);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }

    if (lzy_lyl_1221_P.HILInitialize_OOReset) {
      result = hil_watchdog_set_other_expiration_state
        (lzy_lyl_1221_DW.HILInitialize_Card,
         lzy_lyl_1221_P.HILInitialize_OOChannels, 3U,
         lzy_lyl_1221_P.HILInitialize_OOWatchdog);
      if (result < 0) {
        msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
          (_rt_error_message));
        rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        return;
      }
    }
  }

  /* Start for S-Function (hil_read_encoder_timebase_block): '<S7>/HIL Read Encoder Timebase' */

  /* S-Function Block: lzy_lyl_1221/Subsystem/HIL Read Encoder Timebase (hil_read_encoder_timebase_block) */
  {
    t_error result;
    result = hil_task_create_encoder_reader(lzy_lyl_1221_DW.HILInitialize_Card,
      lzy_lyl_1221_P.HILReadEncoderTimebase_SamplesI,
      lzy_lyl_1221_P.HILReadEncoderTimebase_Channels, 2,
      &lzy_lyl_1221_DW.HILReadEncoderTimebase_Task);
    if (result >= 0) {
      result = hil_task_set_buffer_overflow_mode
        (lzy_lyl_1221_DW.HILReadEncoderTimebase_Task, (t_buffer_overflow_mode)
         (lzy_lyl_1221_P.HILReadEncoderTimebase_Overflow - 1));
    }

    if (result < 0) {
      msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
        (_rt_error_message));
      rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
    }
  }

  /* InitializeConditions for TransferFcn: '<S7>/Transfer Fcn' */
  lzy_lyl_1221_X.TransferFcn_CSTATE = 0.0;

  /* InitializeConditions for TransferFcn: '<S7>/Transfer Fcn1' */
  lzy_lyl_1221_X.TransferFcn1_CSTATE = 0.0;
}

/* Model terminate function */
void lzy_lyl_1221_terminate(void)
{
  /* Terminate for S-Function (hil_initialize_block): '<Root>/HIL Initialize' */

  /* S-Function Block: lzy_lyl_1221/HIL Initialize (hil_initialize_block) */
  {
    t_boolean is_switching;
    t_int result;
    t_uint32 num_final_analog_outputs = 0;
    t_uint32 num_final_digital_outputs = 0;
    t_uint32 num_final_other_outputs = 0;
    hil_task_stop_all(lzy_lyl_1221_DW.HILInitialize_Card);
    hil_monitor_stop_all(lzy_lyl_1221_DW.HILInitialize_Card);
    is_switching = false;
    if ((lzy_lyl_1221_P.HILInitialize_AOTerminate && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_AOExit && is_switching)) {
      num_final_analog_outputs = 1U;
    } else {
      num_final_analog_outputs = 0;
    }

    if ((lzy_lyl_1221_P.HILInitialize_DOTerminate && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_DOExit && is_switching)) {
      num_final_digital_outputs = 1U;
    } else {
      num_final_digital_outputs = 0;
    }

    if ((lzy_lyl_1221_P.HILInitialize_OOTerminate && !is_switching) ||
        (lzy_lyl_1221_P.HILInitialize_OOExit && is_switching)) {
      num_final_other_outputs = 3U;
    } else {
      num_final_other_outputs = 0;
    }

    if (0
        || num_final_analog_outputs > 0
        || num_final_digital_outputs > 0
        || num_final_other_outputs > 0
        ) {
      /* Attempt to write the final outputs atomically (due to firmware issue in old Q2-USB). Otherwise write channels individually */
      result = hil_write(lzy_lyl_1221_DW.HILInitialize_Card
                         , &lzy_lyl_1221_P.HILInitialize_AOChannels,
                         num_final_analog_outputs
                         , NULL, 0
                         , &lzy_lyl_1221_P.HILInitialize_DOChannels,
                         num_final_digital_outputs
                         , lzy_lyl_1221_P.HILInitialize_OOChannels,
                         num_final_other_outputs
                         , &lzy_lyl_1221_P.HILInitialize_AOFinal
                         , NULL
                         , (t_boolean *) &lzy_lyl_1221_P.HILInitialize_DOFinal
                         , lzy_lyl_1221_P.HILInitialize_OOFinal
                         );
      if (result == -QERR_HIL_WRITE_NOT_SUPPORTED) {
        t_error local_result;
        result = 0;

        /* The hil_write operation is not supported by this card. Write final outputs for each channel type */
        if (num_final_analog_outputs > 0) {
          local_result = hil_write_analog(lzy_lyl_1221_DW.HILInitialize_Card,
            &lzy_lyl_1221_P.HILInitialize_AOChannels, num_final_analog_outputs,
            &lzy_lyl_1221_P.HILInitialize_AOFinal);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (num_final_digital_outputs > 0) {
          local_result = hil_write_digital(lzy_lyl_1221_DW.HILInitialize_Card,
            &lzy_lyl_1221_P.HILInitialize_DOChannels, num_final_digital_outputs,
            (t_boolean *) &lzy_lyl_1221_P.HILInitialize_DOFinal);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (num_final_other_outputs > 0) {
          local_result = hil_write_other(lzy_lyl_1221_DW.HILInitialize_Card,
            lzy_lyl_1221_P.HILInitialize_OOChannels, num_final_other_outputs,
            lzy_lyl_1221_P.HILInitialize_OOFinal);
          if (local_result < 0) {
            result = local_result;
          }
        }

        if (result < 0) {
          msg_get_error_messageA(NULL, result, _rt_error_message, sizeof
            (_rt_error_message));
          rtmSetErrorStatus(lzy_lyl_1221_M, _rt_error_message);
        }
      }
    }

    hil_task_delete_all(lzy_lyl_1221_DW.HILInitialize_Card);
    hil_monitor_delete_all(lzy_lyl_1221_DW.HILInitialize_Card);
    hil_close(lzy_lyl_1221_DW.HILInitialize_Card);
    lzy_lyl_1221_DW.HILInitialize_Card = NULL;
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  lzy_lyl_1221_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  lzy_lyl_1221_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  lzy_lyl_1221_initialize();
}

void MdlTerminate(void)
{
  lzy_lyl_1221_terminate();
}

/* Registration function */
RT_MODEL_lzy_lyl_1221_T *lzy_lyl_1221(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)lzy_lyl_1221_M, 0,
                sizeof(RT_MODEL_lzy_lyl_1221_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&lzy_lyl_1221_M->solverInfo,
                          &lzy_lyl_1221_M->Timing.simTimeStep);
    rtsiSetTPtr(&lzy_lyl_1221_M->solverInfo, &rtmGetTPtr(lzy_lyl_1221_M));
    rtsiSetStepSizePtr(&lzy_lyl_1221_M->solverInfo,
                       &lzy_lyl_1221_M->Timing.stepSize0);
    rtsiSetdXPtr(&lzy_lyl_1221_M->solverInfo, &lzy_lyl_1221_M->derivs);
    rtsiSetContStatesPtr(&lzy_lyl_1221_M->solverInfo, (real_T **)
                         &lzy_lyl_1221_M->contStates);
    rtsiSetNumContStatesPtr(&lzy_lyl_1221_M->solverInfo,
      &lzy_lyl_1221_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&lzy_lyl_1221_M->solverInfo,
      &lzy_lyl_1221_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&lzy_lyl_1221_M->solverInfo,
      &lzy_lyl_1221_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&lzy_lyl_1221_M->solverInfo,
      &lzy_lyl_1221_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&lzy_lyl_1221_M->solverInfo, (&rtmGetErrorStatus
      (lzy_lyl_1221_M)));
    rtsiSetRTModelPtr(&lzy_lyl_1221_M->solverInfo, lzy_lyl_1221_M);
  }

  rtsiSetSimTimeStep(&lzy_lyl_1221_M->solverInfo, MAJOR_TIME_STEP);
  lzy_lyl_1221_M->intgData.y = lzy_lyl_1221_M->odeY;
  lzy_lyl_1221_M->intgData.f[0] = lzy_lyl_1221_M->odeF[0];
  lzy_lyl_1221_M->intgData.f[1] = lzy_lyl_1221_M->odeF[1];
  lzy_lyl_1221_M->intgData.f[2] = lzy_lyl_1221_M->odeF[2];
  lzy_lyl_1221_M->contStates = ((real_T *) &lzy_lyl_1221_X);
  rtsiSetSolverData(&lzy_lyl_1221_M->solverInfo, (void *)
                    &lzy_lyl_1221_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&lzy_lyl_1221_M->solverInfo, false);
  rtsiSetSolverName(&lzy_lyl_1221_M->solverInfo,"ode3");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = lzy_lyl_1221_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "lzy_lyl_1221_M points to
       static memory which is guaranteed to be non-NULL" */
    lzy_lyl_1221_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    lzy_lyl_1221_M->Timing.sampleTimes =
      (&lzy_lyl_1221_M->Timing.sampleTimesArray[0]);
    lzy_lyl_1221_M->Timing.offsetTimes =
      (&lzy_lyl_1221_M->Timing.offsetTimesArray[0]);

    /* task periods */
    lzy_lyl_1221_M->Timing.sampleTimes[0] = (0.0);
    lzy_lyl_1221_M->Timing.sampleTimes[1] = (0.002);

    /* task offsets */
    lzy_lyl_1221_M->Timing.offsetTimes[0] = (0.0);
    lzy_lyl_1221_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(lzy_lyl_1221_M, &lzy_lyl_1221_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = lzy_lyl_1221_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    lzy_lyl_1221_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(lzy_lyl_1221_M, -1);
  lzy_lyl_1221_M->Timing.stepSize0 = 0.002;
  lzy_lyl_1221_M->Timing.stepSize1 = 0.002;

  /* External mode info */
  lzy_lyl_1221_M->Sizes.checksums[0] = (3957275191U);
  lzy_lyl_1221_M->Sizes.checksums[1] = (275050817U);
  lzy_lyl_1221_M->Sizes.checksums[2] = (17367548U);
  lzy_lyl_1221_M->Sizes.checksums[3] = (3390007489U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    lzy_lyl_1221_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(lzy_lyl_1221_M->extModeInfo,
      &lzy_lyl_1221_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(lzy_lyl_1221_M->extModeInfo,
                        lzy_lyl_1221_M->Sizes.checksums);
    rteiSetTPtr(lzy_lyl_1221_M->extModeInfo, rtmGetTPtr(lzy_lyl_1221_M));
  }

  lzy_lyl_1221_M->solverInfoPtr = (&lzy_lyl_1221_M->solverInfo);
  lzy_lyl_1221_M->Timing.stepSize = (0.002);
  rtsiSetFixedStepSize(&lzy_lyl_1221_M->solverInfo, 0.002);
  rtsiSetSolverMode(&lzy_lyl_1221_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  lzy_lyl_1221_M->blockIO = ((void *) &lzy_lyl_1221_B);
  (void) memset(((void *) &lzy_lyl_1221_B), 0,
                sizeof(B_lzy_lyl_1221_T));

  /* parameters */
  lzy_lyl_1221_M->defaultParam = ((real_T *)&lzy_lyl_1221_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &lzy_lyl_1221_X;
    lzy_lyl_1221_M->contStates = (x);
    (void) memset((void *)&lzy_lyl_1221_X, 0,
                  sizeof(X_lzy_lyl_1221_T));
  }

  /* states (dwork) */
  lzy_lyl_1221_M->dwork = ((void *) &lzy_lyl_1221_DW);
  (void) memset((void *)&lzy_lyl_1221_DW, 0,
                sizeof(DW_lzy_lyl_1221_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    lzy_lyl_1221_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 21;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  lzy_lyl_1221_M->Sizes.numContStates = (2);/* Number of continuous states */
  lzy_lyl_1221_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  lzy_lyl_1221_M->Sizes.numY = (0);    /* Number of model outputs */
  lzy_lyl_1221_M->Sizes.numU = (0);    /* Number of model inputs */
  lzy_lyl_1221_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  lzy_lyl_1221_M->Sizes.numSampTimes = (2);/* Number of sample times */
  lzy_lyl_1221_M->Sizes.numBlocks = (29);/* Number of blocks */
  lzy_lyl_1221_M->Sizes.numBlockIO = (7);/* Number of block outputs */
  lzy_lyl_1221_M->Sizes.numBlockPrms = (113);/* Sum of parameter "widths" */
  return lzy_lyl_1221_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
