
open Prims
open FStar_Pervasives
type goal =
{context : FStar_TypeChecker_Env.env; witness : FStar_Syntax_Syntax.term; goal_ty : FStar_Syntax_Syntax.typ; opts : FStar_Options.optionstate; is_guard : Prims.bool}


let __proj__Mkgoal__item__context : goal  ->  FStar_TypeChecker_Env.env = (fun projectee -> (match (projectee) with
| {context = __fname__context; witness = __fname__witness; goal_ty = __fname__goal_ty; opts = __fname__opts; is_guard = __fname__is_guard} -> begin
__fname__context
end))


let __proj__Mkgoal__item__witness : goal  ->  FStar_Syntax_Syntax.term = (fun projectee -> (match (projectee) with
| {context = __fname__context; witness = __fname__witness; goal_ty = __fname__goal_ty; opts = __fname__opts; is_guard = __fname__is_guard} -> begin
__fname__witness
end))


let __proj__Mkgoal__item__goal_ty : goal  ->  FStar_Syntax_Syntax.typ = (fun projectee -> (match (projectee) with
| {context = __fname__context; witness = __fname__witness; goal_ty = __fname__goal_ty; opts = __fname__opts; is_guard = __fname__is_guard} -> begin
__fname__goal_ty
end))


let __proj__Mkgoal__item__opts : goal  ->  FStar_Options.optionstate = (fun projectee -> (match (projectee) with
| {context = __fname__context; witness = __fname__witness; goal_ty = __fname__goal_ty; opts = __fname__opts; is_guard = __fname__is_guard} -> begin
__fname__opts
end))


let __proj__Mkgoal__item__is_guard : goal  ->  Prims.bool = (fun projectee -> (match (projectee) with
| {context = __fname__context; witness = __fname__witness; goal_ty = __fname__goal_ty; opts = __fname__opts; is_guard = __fname__is_guard} -> begin
__fname__is_guard
end))

type proofstate =
{main_context : FStar_TypeChecker_Env.env; main_goal : goal; all_implicits : FStar_TypeChecker_Env.implicits; goals : goal Prims.list; smt_goals : goal Prims.list; depth : Prims.int; __dump : proofstate  ->  Prims.string  ->  Prims.unit}


let __proj__Mkproofstate__item__main_context : proofstate  ->  FStar_TypeChecker_Env.env = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__main_context
end))


let __proj__Mkproofstate__item__main_goal : proofstate  ->  goal = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__main_goal
end))


let __proj__Mkproofstate__item__all_implicits : proofstate  ->  FStar_TypeChecker_Env.implicits = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__all_implicits
end))


let __proj__Mkproofstate__item__goals : proofstate  ->  goal Prims.list = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__goals
end))


let __proj__Mkproofstate__item__smt_goals : proofstate  ->  goal Prims.list = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__smt_goals
end))


let __proj__Mkproofstate__item__depth : proofstate  ->  Prims.int = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname__depth
end))


let __proj__Mkproofstate__item____dump : proofstate  ->  proofstate  ->  Prims.string  ->  Prims.unit = (fun projectee -> (match (projectee) with
| {main_context = __fname__main_context; main_goal = __fname__main_goal; all_implicits = __fname__all_implicits; goals = __fname__goals; smt_goals = __fname__smt_goals; depth = __fname__depth; __dump = __fname____dump} -> begin
__fname____dump
end))


let decr_depth : proofstate  ->  proofstate = (fun ps -> (

let uu___106_261 = ps
in {main_context = uu___106_261.main_context; main_goal = uu___106_261.main_goal; all_implicits = uu___106_261.all_implicits; goals = uu___106_261.goals; smt_goals = uu___106_261.smt_goals; depth = (ps.depth - (Prims.parse_int "1")); __dump = uu___106_261.__dump}))


let incr_depth : proofstate  ->  proofstate = (fun ps -> (

let uu___107_266 = ps
in {main_context = uu___107_266.main_context; main_goal = uu___107_266.main_goal; all_implicits = uu___107_266.all_implicits; goals = uu___107_266.goals; smt_goals = uu___107_266.smt_goals; depth = (ps.depth + (Prims.parse_int "1")); __dump = uu___107_266.__dump}))


let tracepoint : proofstate  ->  Prims.unit = (fun ps -> (

let uu____271 = ((FStar_Options.tactic_trace ()) || (

let uu____273 = (FStar_Options.tactic_trace_d ())
in (ps.depth <= uu____273)))
in (match (uu____271) with
| true -> begin
(ps.__dump ps "TRACE")
end
| uu____274 -> begin
()
end)))




