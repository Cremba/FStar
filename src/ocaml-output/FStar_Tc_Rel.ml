
open Prims
# 39 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_kvar : FStar_Range.range  ->  FStar_Absyn_Syntax.binders  ->  ((FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.uvar_basis FStar_Unionfind.uvar) = (fun r binders -> (let u = (FStar_Unionfind.fresh FStar_Absyn_Syntax.Uvar)
in (let _152_7 = (let _152_6 = (let _152_5 = (FStar_Absyn_Util.args_of_non_null_binders binders)
in (u, _152_5))
in (FStar_Absyn_Syntax.mk_Kind_uvar _152_6 r))
in (_152_7, u))))

# 43 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_tvar : FStar_Range.range  ->  FStar_Absyn_Syntax.binder Prims.list  ->  FStar_Absyn_Syntax.knd  ->  ((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) = (fun r binders k -> (let binders = (FStar_All.pipe_right binders (FStar_List.filter (fun x -> (FStar_All.pipe_right (FStar_Absyn_Syntax.is_null_binder x) Prims.op_Negation))))
in (let uv = (FStar_Unionfind.fresh FStar_Absyn_Syntax.Uvar)
in (match (binders) with
| [] -> begin
(let uv = (FStar_Absyn_Syntax.mk_Typ_uvar' (uv, k) None r)
in (uv, uv))
end
| _50_48 -> begin
(let args = (FStar_Absyn_Util.args_of_non_null_binders binders)
in (let k' = (FStar_Absyn_Syntax.mk_Kind_arrow (binders, k) r)
in (let uv = (FStar_Absyn_Syntax.mk_Typ_uvar' (uv, k') None r)
in (let _152_15 = (FStar_Absyn_Syntax.mk_Typ_app (uv, args) None r)
in (_152_15, uv)))))
end))))

# 56 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_evar : FStar_Range.range  ->  FStar_Absyn_Syntax.binder Prims.list  ->  FStar_Absyn_Syntax.typ  ->  ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) = (fun r binders t -> (let binders = (FStar_All.pipe_right binders (FStar_List.filter (fun x -> (FStar_All.pipe_right (FStar_Absyn_Syntax.is_null_binder x) Prims.op_Negation))))
in (let uv = (FStar_Unionfind.fresh FStar_Absyn_Syntax.Uvar)
in (match (binders) with
| [] -> begin
(let uv = (FStar_Absyn_Syntax.mk_Exp_uvar' (uv, t) None r)
in (uv, uv))
end
| _50_61 -> begin
(let args = (FStar_Absyn_Util.args_of_non_null_binders binders)
in (let t' = (let _152_24 = (let _152_23 = (FStar_Absyn_Syntax.mk_Total t)
in (binders, _152_23))
in (FStar_Absyn_Syntax.mk_Typ_fun _152_24 None r))
in (let uv = (FStar_Absyn_Syntax.mk_Exp_uvar' (uv, t') None r)
in (match (args) with
| [] -> begin
(uv, uv)
end
| _50_67 -> begin
(let _152_25 = (FStar_Absyn_Syntax.mk_Exp_app (uv, args) None r)
in (_152_25, uv))
end))))
end))))

# 78 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type rel =
| EQ
| SUB
| SUBINV

# 79 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_EQ : rel  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| EQ -> begin
true
end
| _ -> begin
false
end))

# 80 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_SUB : rel  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| SUB -> begin
true
end
| _ -> begin
false
end))

# 81 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_SUBINV : rel  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| SUBINV -> begin
true
end
| _ -> begin
false
end))

# 83 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type variance =
| COVARIANT
| CONTRAVARIANT
| INVARIANT

# 84 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_COVARIANT : variance  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| COVARIANT -> begin
true
end
| _ -> begin
false
end))

# 85 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_CONTRAVARIANT : variance  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| CONTRAVARIANT -> begin
true
end
| _ -> begin
false
end))

# 86 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_INVARIANT : variance  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| INVARIANT -> begin
true
end
| _ -> begin
false
end))

# 88 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type ('a, 'b) problem =
{lhs : 'a; relation : rel; rhs : 'a; element : 'b Prims.option; logical_guard : (FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.typ); scope : FStar_Absyn_Syntax.binders; reason : Prims.string Prims.list; loc : FStar_Range.range; rank : Prims.int Prims.option}

# 88 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Mkproblem = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkproblem"))))

# 99 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type ('a, 'b) problem_t =
('a, 'b) problem

# 101 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type prob =
| KProb of (FStar_Absyn_Syntax.knd, Prims.unit) problem
| TProb of (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) problem
| EProb of (FStar_Absyn_Syntax.exp, Prims.unit) problem
| CProb of (FStar_Absyn_Syntax.comp, Prims.unit) problem

# 102 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_KProb : prob  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| KProb (_) -> begin
true
end
| _ -> begin
false
end))

# 103 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_TProb : prob  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| TProb (_) -> begin
true
end
| _ -> begin
false
end))

# 104 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_EProb : prob  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| EProb (_) -> begin
true
end
| _ -> begin
false
end))

# 105 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_CProb : prob  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| CProb (_) -> begin
true
end
| _ -> begin
false
end))

# 102 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___KProb____0 : prob  ->  (FStar_Absyn_Syntax.knd, Prims.unit) problem = (fun projectee -> (match (projectee) with
| KProb (_50_84) -> begin
_50_84
end))

# 103 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___TProb____0 : prob  ->  (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) problem = (fun projectee -> (match (projectee) with
| TProb (_50_87) -> begin
_50_87
end))

# 104 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___EProb____0 : prob  ->  (FStar_Absyn_Syntax.exp, Prims.unit) problem = (fun projectee -> (match (projectee) with
| EProb (_50_90) -> begin
_50_90
end))

# 105 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___CProb____0 : prob  ->  (FStar_Absyn_Syntax.comp, Prims.unit) problem = (fun projectee -> (match (projectee) with
| CProb (_50_93) -> begin
_50_93
end))

# 107 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type probs =
prob Prims.list

# 110 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type uvi =
| UK of (FStar_Absyn_Syntax.uvar_k * FStar_Absyn_Syntax.knd)
| UT of ((FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd) * FStar_Absyn_Syntax.typ)
| UE of ((FStar_Absyn_Syntax.uvar_e * FStar_Absyn_Syntax.typ) * FStar_Absyn_Syntax.exp)

# 111 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_UK : uvi  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| UK (_) -> begin
true
end
| _ -> begin
false
end))

# 112 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_UT : uvi  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| UT (_) -> begin
true
end
| _ -> begin
false
end))

# 113 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_UE : uvi  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| UE (_) -> begin
true
end
| _ -> begin
false
end))

# 111 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___UK____0 : uvi  ->  (FStar_Absyn_Syntax.uvar_k * FStar_Absyn_Syntax.knd) = (fun projectee -> (match (projectee) with
| UK (_50_96) -> begin
_50_96
end))

# 112 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___UT____0 : uvi  ->  ((FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd) * FStar_Absyn_Syntax.typ) = (fun projectee -> (match (projectee) with
| UT (_50_99) -> begin
_50_99
end))

# 113 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___UE____0 : uvi  ->  ((FStar_Absyn_Syntax.uvar_e * FStar_Absyn_Syntax.typ) * FStar_Absyn_Syntax.exp) = (fun projectee -> (match (projectee) with
| UE (_50_102) -> begin
_50_102
end))

# 116 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type worklist =
{attempting : probs; wl_deferred : (Prims.int * Prims.string * prob) Prims.list; subst : uvi Prims.list; ctr : Prims.int; slack_vars : (Prims.bool * FStar_Absyn_Syntax.typ) Prims.list; defer_ok : Prims.bool; smt_ok : Prims.bool; tcenv : FStar_Tc_Env.env}

# 116 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Mkworklist : worklist  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkworklist"))))

# 128 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type deferred =
{carry : (Prims.string * prob) Prims.list; slack : (Prims.bool * FStar_Absyn_Syntax.typ) Prims.list}

# 128 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Mkdeferred : deferred  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkdeferred"))))

# 132 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let no_deferred : deferred = {carry = []; slack = []}

# 136 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type solution =
| Success of (uvi Prims.list * deferred)
| Failed of (prob * Prims.string)

# 137 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Success : solution  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| Success (_) -> begin
true
end
| _ -> begin
false
end))

# 138 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Failed : solution  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| Failed (_) -> begin
true
end
| _ -> begin
false
end))

# 137 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___Success____0 : solution  ->  (uvi Prims.list * deferred) = (fun projectee -> (match (projectee) with
| Success (_50_117) -> begin
_50_117
end))

# 138 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___Failed____0 : solution  ->  (prob * Prims.string) = (fun projectee -> (match (projectee) with
| Failed (_50_120) -> begin
_50_120
end))

# 147 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rel_to_string : rel  ->  Prims.string = (fun _50_1 -> (match (_50_1) with
| EQ -> begin
"="
end
| SUB -> begin
"<:"
end
| SUBINV -> begin
":>"
end))

# 152 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let prob_to_string : FStar_Tc_Env.env  ->  prob  ->  Prims.string = (fun env _50_2 -> (match (_50_2) with
| KProb (p) -> begin
(let _152_227 = (FStar_Absyn_Print.kind_to_string p.lhs)
in (let _152_226 = (FStar_Absyn_Print.kind_to_string p.rhs)
in (FStar_Util.format3 "\t%s\n\t\t%s\n\t%s" _152_227 (rel_to_string p.relation) _152_226)))
end
| TProb (p) -> begin
(let _152_240 = (let _152_239 = (FStar_Tc_Normalize.typ_norm_to_string env p.lhs)
in (let _152_238 = (let _152_237 = (FStar_Absyn_Print.tag_of_typ p.lhs)
in (let _152_236 = (let _152_235 = (let _152_234 = (FStar_All.pipe_right p.reason FStar_List.hd)
in (let _152_233 = (let _152_232 = (FStar_Tc_Normalize.typ_norm_to_string env p.rhs)
in (let _152_231 = (let _152_230 = (FStar_Absyn_Print.tag_of_typ p.rhs)
in (let _152_229 = (let _152_228 = (FStar_Tc_Normalize.formula_norm_to_string env (Prims.fst p.logical_guard))
in (_152_228)::[])
in (_152_230)::_152_229))
in (_152_232)::_152_231))
in (_152_234)::_152_233))
in ((rel_to_string p.relation))::_152_235)
in (_152_237)::_152_236))
in (_152_239)::_152_238))
in (FStar_Util.format "\t%s (%s) \n\t\t%s(%s)\n\t%s (%s) (guard %s)" _152_240))
end
| EProb (p) -> begin
(let _152_242 = (FStar_Tc_Normalize.exp_norm_to_string env p.lhs)
in (let _152_241 = (FStar_Tc_Normalize.exp_norm_to_string env p.rhs)
in (FStar_Util.format3 "\t%s \n\t\t%s\n\t%s" _152_242 (rel_to_string p.relation) _152_241)))
end
| CProb (p) -> begin
(let _152_244 = (FStar_Tc_Normalize.comp_typ_norm_to_string env p.lhs)
in (let _152_243 = (FStar_Tc_Normalize.comp_typ_norm_to_string env p.rhs)
in (FStar_Util.format3 "\t%s \n\t\t%s\n\t%s" _152_244 (rel_to_string p.relation) _152_243)))
end))

# 166 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let uvi_to_string : FStar_Tc_Env.env  ->  uvi  ->  Prims.string = (fun env uvi -> (let str = (fun u -> if (FStar_ST.read FStar_Options.hide_uvar_nums) then begin
"?"
end else begin
(let _152_250 = (FStar_Unionfind.uvar_id u)
in (FStar_All.pipe_right _152_250 FStar_Util.string_of_int))
end)
in (match (uvi) with
| UK (u, _50_142) -> begin
(let _152_251 = (str u)
in (FStar_All.pipe_right _152_251 (FStar_Util.format1 "UK %s")))
end
| UT ((u, _50_147), t) -> begin
(let _152_254 = (str u)
in (FStar_All.pipe_right _152_254 (fun x -> (let _152_253 = (FStar_Tc_Normalize.typ_norm_to_string env t)
in (FStar_Util.format2 "UT %s %s" x _152_253)))))
end
| UE ((u, _50_155), _50_158) -> begin
(let _152_255 = (str u)
in (FStar_All.pipe_right _152_255 (FStar_Util.format1 "UE %s")))
end)))

# 181 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let invert_rel : rel  ->  rel = (fun _50_3 -> (match (_50_3) with
| EQ -> begin
EQ
end
| SUB -> begin
SUBINV
end
| SUBINV -> begin
SUB
end))

# 185 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let invert = (fun p -> (let _50_166 = p
in {lhs = p.rhs; relation = (invert_rel p.relation); rhs = p.lhs; element = _50_166.element; logical_guard = _50_166.logical_guard; scope = _50_166.scope; reason = _50_166.reason; loc = _50_166.loc; rank = _50_166.rank}))

# 186 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let maybe_invert = (fun p -> if (p.relation = SUBINV) then begin
(invert p)
end else begin
p
end)

# 187 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let maybe_invert_p : prob  ->  prob = (fun _50_4 -> (match (_50_4) with
| KProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _152_262 -> KProb (_152_262)))
end
| TProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _152_263 -> TProb (_152_263)))
end
| EProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _152_264 -> EProb (_152_264)))
end
| CProb (p) -> begin
(FStar_All.pipe_right (maybe_invert p) (fun _152_265 -> CProb (_152_265)))
end))

# 192 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let vary_rel : rel  ->  variance  ->  rel = (fun rel _50_5 -> (match (_50_5) with
| INVARIANT -> begin
EQ
end
| CONTRAVARIANT -> begin
(invert_rel rel)
end
| COVARIANT -> begin
rel
end))

# 196 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_rel : prob  ->  rel = (fun _50_6 -> (match (_50_6) with
| KProb (p) -> begin
p.relation
end
| TProb (p) -> begin
p.relation
end
| EProb (p) -> begin
p.relation
end
| CProb (p) -> begin
p.relation
end))

# 201 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_reason : prob  ->  Prims.string Prims.list = (fun _50_7 -> (match (_50_7) with
| KProb (p) -> begin
p.reason
end
| TProb (p) -> begin
p.reason
end
| EProb (p) -> begin
p.reason
end
| CProb (p) -> begin
p.reason
end))

# 206 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_loc : prob  ->  FStar_Range.range = (fun _50_8 -> (match (_50_8) with
| KProb (p) -> begin
p.loc
end
| TProb (p) -> begin
p.loc
end
| EProb (p) -> begin
p.loc
end
| CProb (p) -> begin
p.loc
end))

# 211 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_context : prob  ->  FStar_Absyn_Syntax.binders = (fun _50_9 -> (match (_50_9) with
| KProb (p) -> begin
p.scope
end
| TProb (p) -> begin
p.scope
end
| EProb (p) -> begin
p.scope
end
| CProb (p) -> begin
p.scope
end))

# 216 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_guard : prob  ->  (FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.typ) = (fun _50_10 -> (match (_50_10) with
| KProb (p) -> begin
p.logical_guard
end
| TProb (p) -> begin
p.logical_guard
end
| EProb (p) -> begin
p.logical_guard
end
| CProb (p) -> begin
p.logical_guard
end))

# 221 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_scope : prob  ->  FStar_Absyn_Syntax.binders = (fun _50_11 -> (match (_50_11) with
| KProb (p) -> begin
p.scope
end
| TProb (p) -> begin
p.scope
end
| EProb (p) -> begin
p.scope
end
| CProb (p) -> begin
p.scope
end))

# 226 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let p_invert : prob  ->  prob = (fun _50_12 -> (match (_50_12) with
| KProb (p) -> begin
(FStar_All.pipe_left (fun _152_284 -> KProb (_152_284)) (invert p))
end
| TProb (p) -> begin
(FStar_All.pipe_left (fun _152_285 -> TProb (_152_285)) (invert p))
end
| EProb (p) -> begin
(FStar_All.pipe_left (fun _152_286 -> EProb (_152_286)) (invert p))
end
| CProb (p) -> begin
(FStar_All.pipe_left (fun _152_287 -> CProb (_152_287)) (invert p))
end))

# 231 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_top_level_prob : prob  ->  Prims.bool = (fun p -> ((FStar_All.pipe_right (p_reason p) FStar_List.length) = 1))

# 233 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let mk_problem = (fun scope orig lhs rel rhs elt reason -> (let _152_297 = (new_tvar (p_loc orig) scope FStar_Absyn_Syntax.ktype)
in {lhs = lhs; relation = rel; rhs = rhs; element = elt; logical_guard = _152_297; scope = []; reason = (reason)::(p_reason orig); loc = (p_loc orig); rank = None}))

# 244 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_problem = (fun env lhs rel rhs elt loc reason -> (let _152_306 = (let _152_305 = (FStar_Tc_Env.binders env)
in (new_tvar (FStar_Tc_Env.get_range env) _152_305 FStar_Absyn_Syntax.ktype))
in {lhs = lhs; relation = rel; rhs = rhs; element = elt; logical_guard = _152_306; scope = []; reason = (reason)::[]; loc = loc; rank = None}))

# 255 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let problem_using_guard = (fun orig lhs rel rhs elt reason -> {lhs = lhs; relation = rel; rhs = rhs; element = elt; logical_guard = (p_guard orig); scope = []; reason = (reason)::(p_reason orig); loc = (p_loc orig); rank = None})

# 266 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let guard_on_element = (fun problem x phi -> (match (problem.element) with
| None -> begin
(FStar_Absyn_Util.close_forall (((FStar_Absyn_Syntax.v_binder x))::[]) phi)
end
| Some (e) -> begin
(FStar_Absyn_Util.subst_typ ((FStar_Util.Inr ((x.FStar_Absyn_Syntax.v, e)))::[]) phi)
end))

# 270 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let solve_prob' : Prims.bool  ->  prob  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun resolve_ok prob logical_guard uvis wl -> (let phi = (match (logical_guard) with
| None -> begin
FStar_Absyn_Util.t_true
end
| Some (phi) -> begin
phi
end)
in (let _50_285 = (p_guard prob)
in (match (_50_285) with
| (_50_283, uv) -> begin
(let _50_293 = (match ((let _152_326 = (FStar_Absyn_Util.compress_typ uv)
in _152_326.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_uvar (uvar, k) -> begin
(let phi = (FStar_Absyn_Util.close_for_kind phi k)
in (FStar_Absyn_Util.unchecked_unify uvar phi))
end
| _50_292 -> begin
if (not (resolve_ok)) then begin
(FStar_All.failwith "Impossible: this instance has already been assigned a solution")
end else begin
()
end
end)
in (match (uvis) with
| [] -> begin
wl
end
| _50_297 -> begin
(let _50_298 = if (FStar_All.pipe_left (FStar_Tc_Env.debug wl.tcenv) (FStar_Options.Other ("Rel"))) then begin
(let _152_328 = (let _152_327 = (FStar_List.map (uvi_to_string wl.tcenv) uvis)
in (FStar_All.pipe_right _152_327 (FStar_String.concat ", ")))
in (FStar_Util.print1 "Extending solution: %s\n" _152_328))
end else begin
()
end
in (let _50_300 = wl
in {attempting = _50_300.attempting; wl_deferred = _50_300.wl_deferred; subst = (FStar_List.append uvis wl.subst); ctr = (wl.ctr + 1); slack_vars = _50_300.slack_vars; defer_ok = _50_300.defer_ok; smt_ok = _50_300.smt_ok; tcenv = _50_300.tcenv}))
end))
end))))

# 287 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let extend_solution : uvi  ->  worklist  ->  worklist = (fun sol wl -> (let _50_304 = wl
in {attempting = _50_304.attempting; wl_deferred = _50_304.wl_deferred; subst = (sol)::wl.subst; ctr = (wl.ctr + 1); slack_vars = _50_304.slack_vars; defer_ok = _50_304.defer_ok; smt_ok = _50_304.smt_ok; tcenv = _50_304.tcenv}))

# 288 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let solve_prob : prob  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax Prims.option  ->  uvi Prims.list  ->  worklist  ->  worklist = (fun prob logical_guard uvis wl -> (solve_prob' false prob logical_guard uvis wl))

# 289 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let explain : FStar_Tc_Env.env  ->  prob  ->  Prims.string  ->  Prims.string = (fun env d s -> (let _152_349 = (FStar_All.pipe_left FStar_Range.string_of_range (p_loc d))
in (let _152_348 = (prob_to_string env d)
in (let _152_347 = (FStar_All.pipe_right (p_reason d) (FStar_String.concat "\n\t>"))
in (FStar_Util.format4 "(%s) Failed to solve the sub-problem\n%s\nWhich arose because:\n\t%s\nFailed because:%s\n" _152_349 _152_348 _152_347 s)))))

# 304 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let empty_worklist : FStar_Tc_Env.env  ->  worklist = (fun env -> {attempting = []; wl_deferred = []; subst = []; ctr = 0; slack_vars = []; defer_ok = true; smt_ok = true; tcenv = env})

# 314 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let singleton : FStar_Tc_Env.env  ->  prob  ->  worklist = (fun env prob -> (let _50_316 = (empty_worklist env)
in {attempting = (prob)::[]; wl_deferred = _50_316.wl_deferred; subst = _50_316.subst; ctr = _50_316.ctr; slack_vars = _50_316.slack_vars; defer_ok = _50_316.defer_ok; smt_ok = _50_316.smt_ok; tcenv = _50_316.tcenv}))

# 315 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let wl_of_guard : FStar_Tc_Env.env  ->  deferred  ->  worklist = (fun env g -> (let _50_320 = (empty_worklist env)
in (let _152_360 = (FStar_List.map Prims.snd g.carry)
in {attempting = _152_360; wl_deferred = _50_320.wl_deferred; subst = _50_320.subst; ctr = _50_320.ctr; slack_vars = g.slack; defer_ok = false; smt_ok = _50_320.smt_ok; tcenv = _50_320.tcenv})))

# 316 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let defer : Prims.string  ->  prob  ->  worklist  ->  worklist = (fun reason prob wl -> (let _50_325 = wl
in {attempting = _50_325.attempting; wl_deferred = ((wl.ctr, reason, prob))::wl.wl_deferred; subst = _50_325.subst; ctr = _50_325.ctr; slack_vars = _50_325.slack_vars; defer_ok = _50_325.defer_ok; smt_ok = _50_325.smt_ok; tcenv = _50_325.tcenv}))

# 317 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let attempt : prob Prims.list  ->  worklist  ->  worklist = (fun probs wl -> (let _50_329 = wl
in {attempting = (FStar_List.append probs wl.attempting); wl_deferred = _50_329.wl_deferred; subst = _50_329.subst; ctr = _50_329.ctr; slack_vars = _50_329.slack_vars; defer_ok = _50_329.defer_ok; smt_ok = _50_329.smt_ok; tcenv = _50_329.tcenv}))

# 318 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let add_slack_mul : FStar_Absyn_Syntax.typ  ->  worklist  ->  worklist = (fun slack wl -> (let _50_333 = wl
in {attempting = _50_333.attempting; wl_deferred = _50_333.wl_deferred; subst = _50_333.subst; ctr = _50_333.ctr; slack_vars = ((true, slack))::wl.slack_vars; defer_ok = _50_333.defer_ok; smt_ok = _50_333.smt_ok; tcenv = _50_333.tcenv}))

# 319 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let add_slack_add : FStar_Absyn_Syntax.typ  ->  worklist  ->  worklist = (fun slack wl -> (let _50_337 = wl
in {attempting = _50_337.attempting; wl_deferred = _50_337.wl_deferred; subst = _50_337.subst; ctr = _50_337.ctr; slack_vars = ((false, slack))::wl.slack_vars; defer_ok = _50_337.defer_ok; smt_ok = _50_337.smt_ok; tcenv = _50_337.tcenv}))

# 321 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let giveup : FStar_Tc_Env.env  ->  Prims.string  ->  prob  ->  solution = (fun env reason prob -> (let _50_342 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_385 = (prob_to_string env prob)
in (FStar_Util.print2 "Failed %s:\n%s\n" reason _152_385))
end else begin
()
end
in Failed ((prob, reason))))

# 332 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let commit = (fun env uvis -> (FStar_All.pipe_right uvis (FStar_List.iter (fun _50_13 -> (match (_50_13) with
| UK (u, k) -> begin
(FStar_Absyn_Util.unchecked_unify u k)
end
| UT ((u, k), t) -> begin
(FStar_Absyn_Util.unchecked_unify u t)
end
| UE ((u, _50_359), e) -> begin
(FStar_Absyn_Util.unchecked_unify u e)
end)))))

# 338 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let find_uvar_k : (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.uvar_basis FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Absyn_Syntax.knd Prims.option = (fun uv s -> (FStar_Util.find_map s (fun _50_14 -> (match (_50_14) with
| UK (u, t) -> begin
if (FStar_Unionfind.equivalent uv u) then begin
Some (t)
end else begin
None
end
end
| _50_372 -> begin
None
end))))

# 339 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let find_uvar_t : (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.uvar_basis FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Absyn_Syntax.typ Prims.option = (fun uv s -> (FStar_Util.find_map s (fun _50_15 -> (match (_50_15) with
| UT ((u, _50_378), t) -> begin
if (FStar_Unionfind.equivalent uv u) then begin
Some (t)
end else begin
None
end
end
| _50_384 -> begin
None
end))))

# 340 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let find_uvar_e : (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.uvar_basis FStar_Unionfind.uvar  ->  uvi Prims.list  ->  FStar_Absyn_Syntax.exp Prims.option = (fun uv s -> (FStar_Util.find_map s (fun _50_16 -> (match (_50_16) with
| UE ((u, _50_390), t) -> begin
if (FStar_Unionfind.equivalent uv u) then begin
Some (t)
end else begin
None
end
end
| _50_396 -> begin
None
end))))

# 349 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let simplify_formula : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun env f -> (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Simplify)::[]) env f))

# 350 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let norm_targ : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ = (fun env t -> (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::[]) env t))

# 351 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let norm_arg = (fun env a -> (match ((Prims.fst a)) with
| FStar_Util.Inl (t) -> begin
(let _152_416 = (let _152_415 = (norm_targ env t)
in (FStar_All.pipe_left (fun _152_414 -> FStar_Util.Inl (_152_414)) _152_415))
in (_152_416, (Prims.snd a)))
end
| FStar_Util.Inr (v) -> begin
(let _152_419 = (let _152_418 = (FStar_Tc_Normalize.norm_exp ((FStar_Tc_Normalize.Beta)::[]) env v)
in (FStar_All.pipe_left (fun _152_417 -> FStar_Util.Inr (_152_417)) _152_418))
in (_152_419, (Prims.snd a)))
end))

# 354 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let whnf : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t -> (let _152_424 = (FStar_Tc_Normalize.whnf env t)
in (FStar_All.pipe_right _152_424 FStar_Absyn_Util.compress_typ)))

# 355 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let sn : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t -> (let _152_429 = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::[]) env t)
in (FStar_All.pipe_right _152_429 FStar_Absyn_Util.compress_typ)))

# 356 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let sn_binders = (fun env binders -> (FStar_All.pipe_right binders (FStar_List.map (fun _50_17 -> (match (_50_17) with
| (FStar_Util.Inl (a), imp) -> begin
(let _152_435 = (let _152_434 = (let _50_418 = a
in (let _152_433 = (FStar_Tc_Normalize.norm_kind ((FStar_Tc_Normalize.Beta)::[]) env a.FStar_Absyn_Syntax.sort)
in {FStar_Absyn_Syntax.v = _50_418.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.sort = _152_433; FStar_Absyn_Syntax.p = _50_418.FStar_Absyn_Syntax.p}))
in FStar_Util.Inl (_152_434))
in (_152_435, imp))
end
| (FStar_Util.Inr (x), imp) -> begin
(let _152_438 = (let _152_437 = (let _50_424 = x
in (let _152_436 = (norm_targ env x.FStar_Absyn_Syntax.sort)
in {FStar_Absyn_Syntax.v = _50_424.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.sort = _152_436; FStar_Absyn_Syntax.p = _50_424.FStar_Absyn_Syntax.p}))
in FStar_Util.Inr (_152_437))
in (_152_438, imp))
end)))))

# 362 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let whnf_k : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.knd  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax = (fun env k -> (let _152_443 = (FStar_Tc_Normalize.norm_kind ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.WHNF)::[]) env k)
in (FStar_All.pipe_right _152_443 FStar_Absyn_Util.compress_kind)))

# 363 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let whnf_e : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.exp  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env e -> (let _152_448 = (FStar_Tc_Normalize.norm_exp ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.WHNF)::[]) env e)
in (FStar_All.pipe_right _152_448 FStar_Absyn_Util.compress_exp)))

# 365 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec compress_k : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax = (fun env wl k -> (let k = (FStar_Absyn_Util.compress_kind k)
in (match (k.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Kind_uvar (uv, actuals) -> begin
(match ((find_uvar_k uv wl.subst)) with
| None -> begin
k
end
| Some (k') -> begin
(match (k'.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Kind_lam (formals, body) -> begin
(let k = (let _152_455 = (FStar_Absyn_Util.subst_of_list formals actuals)
in (FStar_Absyn_Util.subst_kind _152_455 body))
in (compress_k env wl k))
end
| _50_447 -> begin
if ((FStar_List.length actuals) = 0) then begin
(compress_k env wl k')
end else begin
(FStar_All.failwith "Wrong arity for kind unifier")
end
end)
end)
end
| _50_449 -> begin
k
end)))

# 381 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec compress : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env wl t -> (let t = (let _152_462 = (FStar_Absyn_Util.unmeta_typ t)
in (whnf env _152_462))
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_uvar (uv, _50_456) -> begin
(match ((find_uvar_t uv wl.subst)) with
| None -> begin
t
end
| Some (t) -> begin
(compress env wl t)
end)
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (uv, _50_472); FStar_Absyn_Syntax.tk = _50_469; FStar_Absyn_Syntax.pos = _50_467; FStar_Absyn_Syntax.fvs = _50_465; FStar_Absyn_Syntax.uvs = _50_463}, args) -> begin
(match ((find_uvar_t uv wl.subst)) with
| Some (t') -> begin
(let t = (FStar_Absyn_Syntax.mk_Typ_app (t', args) None t.FStar_Absyn_Syntax.pos)
in (compress env wl t))
end
| _50_483 -> begin
t
end)
end
| _50_485 -> begin
t
end)))

# 396 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec compress_e : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env wl e -> (let e = (FStar_Absyn_Util.unmeta_exp e)
in (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_uvar (uv, t) -> begin
(match ((find_uvar_e uv wl.subst)) with
| None -> begin
e
end
| Some (e') -> begin
(compress_e env wl e')
end)
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (uv, _50_507); FStar_Absyn_Syntax.tk = _50_504; FStar_Absyn_Syntax.pos = _50_502; FStar_Absyn_Syntax.fvs = _50_500; FStar_Absyn_Syntax.uvs = _50_498}, args) -> begin
(match ((find_uvar_e uv wl.subst)) with
| None -> begin
e
end
| Some (e') -> begin
(let e' = (compress_e env wl e')
in (FStar_Absyn_Syntax.mk_Exp_app (e', args) None e.FStar_Absyn_Syntax.pos))
end)
end
| _50_519 -> begin
e
end)))

# 413 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let normalize_refinement : FStar_Tc_Normalize.step Prims.list  ->  FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun steps env wl t0 -> (let _152_477 = (compress env wl t0)
in (FStar_Tc_Normalize.normalize_refinement steps env _152_477)))

# 415 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let base_and_refinement : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  ((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.bvvar * FStar_Absyn_Syntax.typ) Prims.option) = (fun env wl t1 -> (let rec aux = (fun norm t1 -> (match (t1.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_refine (x, phi) -> begin
if norm then begin
(x.FStar_Absyn_Syntax.sort, Some ((x, phi)))
end else begin
(match ((normalize_refinement [] env wl t1)) with
| {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_refine (x, phi); FStar_Absyn_Syntax.tk = _50_541; FStar_Absyn_Syntax.pos = _50_539; FStar_Absyn_Syntax.fvs = _50_537; FStar_Absyn_Syntax.uvs = _50_535} -> begin
(x.FStar_Absyn_Syntax.sort, Some ((x, phi)))
end
| tt -> begin
(let _152_490 = (let _152_489 = (FStar_Absyn_Print.typ_to_string tt)
in (let _152_488 = (FStar_Absyn_Print.tag_of_typ tt)
in (FStar_Util.format2 "impossible: Got %s ... %s\n" _152_489 _152_488)))
in (FStar_All.failwith _152_490))
end)
end
end
| (FStar_Absyn_Syntax.Typ_const (_)) | (FStar_Absyn_Syntax.Typ_app (_)) -> begin
if norm then begin
(t1, None)
end else begin
(let _50_556 = (let _152_491 = (normalize_refinement [] env wl t1)
in (aux true _152_491))
in (match (_50_556) with
| (t2', refinement) -> begin
(match (refinement) with
| None -> begin
(t1, None)
end
| _50_559 -> begin
(t2', refinement)
end)
end))
end
end
| (FStar_Absyn_Syntax.Typ_btvar (_)) | (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_lam (_)) | (FStar_Absyn_Syntax.Typ_uvar (_)) -> begin
(t1, None)
end
| (FStar_Absyn_Syntax.Typ_ascribed (_)) | (FStar_Absyn_Syntax.Typ_delayed (_)) | (FStar_Absyn_Syntax.Typ_meta (_)) | (FStar_Absyn_Syntax.Typ_unknown) -> begin
(let _152_494 = (let _152_493 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_492 = (FStar_Absyn_Print.tag_of_typ t1)
in (FStar_Util.format2 "impossible (outer): Got %s ... %s\n" _152_493 _152_492)))
in (FStar_All.failwith _152_494))
end))
in (let _152_495 = (compress env wl t1)
in (aux false _152_495))))

# 447 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let unrefine : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun env t -> (let _152_500 = (base_and_refinement env (empty_worklist env) t)
in (FStar_All.pipe_right _152_500 Prims.fst)))

# 449 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let trivial_refinement = (fun t -> (let _152_502 = (FStar_Absyn_Util.gen_bvar_p t.FStar_Absyn_Syntax.pos t)
in (_152_502, FStar_Absyn_Util.t_true)))

# 451 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let as_refinement : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) = (fun env wl t -> (let _50_590 = (base_and_refinement env wl t)
in (match (_50_590) with
| (t_base, refinement) -> begin
(match (refinement) with
| None -> begin
(trivial_refinement t_base)
end
| Some (x, phi) -> begin
(x, phi)
end)
end)))

# 459 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let force_refinement : ((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) Prims.option)  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax = (fun _50_598 -> (match (_50_598) with
| (t_base, refopt) -> begin
(let _50_606 = (match (refopt) with
| Some (y, phi) -> begin
(y, phi)
end
| None -> begin
(trivial_refinement t_base)
end)
in (match (_50_606) with
| (y, phi) -> begin
(FStar_Absyn_Syntax.mk_Typ_refine (y, phi) None t_base.FStar_Absyn_Syntax.pos)
end))
end))

# 472 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec occurs = (fun env wl uk t -> (let uvs = (FStar_Absyn_Util.uvars_in_typ t)
in (let _152_522 = (FStar_All.pipe_right uvs.FStar_Absyn_Syntax.uvars_t FStar_Util.set_elements)
in (FStar_All.pipe_right _152_522 (FStar_Util.for_some (fun _50_617 -> (match (_50_617) with
| (uvt, _50_616) -> begin
(match ((find_uvar_t uvt wl.subst)) with
| None -> begin
(FStar_Unionfind.equivalent uvt (Prims.fst uk))
end
| Some (t) -> begin
(let t = (match ((FStar_Absyn_Util.compress_typ t)) with
| {FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_lam (_50_630, t); FStar_Absyn_Syntax.tk = _50_628; FStar_Absyn_Syntax.pos = _50_626; FStar_Absyn_Syntax.fvs = _50_624; FStar_Absyn_Syntax.uvs = _50_622} -> begin
t
end
| t -> begin
t
end)
in (occurs env wl uk t))
end)
end)))))))

# 483 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let occurs_check : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd)  ->  FStar_Absyn_Syntax.typ  ->  (Prims.bool * Prims.string Prims.option) = (fun env wl uk t -> (let occurs_ok = (not ((occurs env wl uk t)))
in (let msg = if occurs_ok then begin
None
end else begin
(let _152_535 = (let _152_534 = (FStar_Absyn_Print.uvar_t_to_string uk)
in (let _152_533 = (FStar_Absyn_Print.typ_to_string t)
in (let _152_532 = (let _152_531 = (FStar_All.pipe_right wl.subst (FStar_List.map (uvi_to_string env)))
in (FStar_All.pipe_right _152_531 (FStar_String.concat ", ")))
in (FStar_Util.format3 "occurs-check failed (%s occurs in %s) (with substitution %s)" _152_534 _152_533 _152_532))))
in Some (_152_535))
end
in (occurs_ok, msg))))

# 493 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let occurs_and_freevars_check : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd)  ->  FStar_Absyn_Syntax.freevars  ->  FStar_Absyn_Syntax.typ  ->  (Prims.bool * Prims.bool * (Prims.string Prims.option * FStar_Absyn_Syntax.freevars * FStar_Absyn_Syntax.freevars)) = (fun env wl uk fvs t -> (let fvs_t = (FStar_Absyn_Util.freevars_typ t)
in (let _50_651 = (occurs_check env wl uk t)
in (match (_50_651) with
| (occurs_ok, msg) -> begin
(let _152_546 = (FStar_Absyn_Util.fvs_included fvs_t fvs)
in (occurs_ok, _152_546, (msg, fvs, fvs_t)))
end))))

# 498 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let occurs_check_e : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.uvar_e * FStar_Absyn_Syntax.typ)  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (Prims.bool * Prims.string Prims.option) = (fun env ut e -> (let uvs = (FStar_Absyn_Util.uvars_in_exp e)
in (let occurs_ok = (not ((FStar_Util.set_mem ut uvs.FStar_Absyn_Syntax.uvars_e)))
in (let msg = if occurs_ok then begin
None
end else begin
(let _152_558 = (let _152_557 = (FStar_Absyn_Print.uvar_e_to_string ut)
in (let _152_556 = (let _152_554 = (let _152_553 = (FStar_Util.set_elements uvs.FStar_Absyn_Syntax.uvars_e)
in (FStar_All.pipe_right _152_553 (FStar_List.map FStar_Absyn_Print.uvar_e_to_string)))
in (FStar_All.pipe_right _152_554 (FStar_String.concat ", ")))
in (let _152_555 = (FStar_Tc_Normalize.exp_norm_to_string env e)
in (FStar_Util.format3 "occurs-check failed (%s occurs in {%s} uvars of %s)" _152_557 _152_556 _152_555))))
in Some (_152_558))
end
in (occurs_ok, msg)))))

# 510 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let intersect_vars : FStar_Absyn_Syntax.binders  ->  FStar_Absyn_Syntax.binders  ->  ((FStar_Absyn_Syntax.btvar, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list = (fun v1 v2 -> (let fvs1 = (FStar_Absyn_Syntax.freevars_of_binders v1)
in (let fvs2 = (FStar_Absyn_Syntax.freevars_of_binders v2)
in (let _152_565 = (let _152_564 = (FStar_Util.set_intersect fvs1.FStar_Absyn_Syntax.ftvs fvs2.FStar_Absyn_Syntax.ftvs)
in (let _152_563 = (FStar_Util.set_intersect fvs1.FStar_Absyn_Syntax.fxvs fvs2.FStar_Absyn_Syntax.fxvs)
in {FStar_Absyn_Syntax.ftvs = _152_564; FStar_Absyn_Syntax.fxvs = _152_563}))
in (FStar_Absyn_Syntax.binders_of_freevars _152_565)))))

# 515 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let binders_eq = (fun v1 v2 -> (((FStar_List.length v1) = (FStar_List.length v2)) && (FStar_List.forall2 (fun ax1 ax2 -> (match (((Prims.fst ax1), (Prims.fst ax2))) with
| (FStar_Util.Inl (a), FStar_Util.Inl (b)) -> begin
(FStar_Absyn_Util.bvar_eq a b)
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(FStar_Absyn_Util.bvar_eq x y)
end
| _50_677 -> begin
false
end)) v1 v2)))

# 522 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let pat_var_opt = (fun env seen arg -> (let hd = (norm_arg env arg)
in (match ((FStar_All.pipe_left Prims.fst hd)) with
| FStar_Util.Inl ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_btvar (a); FStar_Absyn_Syntax.tk = _50_689; FStar_Absyn_Syntax.pos = _50_687; FStar_Absyn_Syntax.fvs = _50_685; FStar_Absyn_Syntax.uvs = _50_683}) -> begin
if (FStar_All.pipe_right seen (FStar_Util.for_some (fun _50_18 -> (match (_50_18) with
| (FStar_Util.Inl (b), _50_698) -> begin
(FStar_Absyn_Syntax.bvd_eq a.FStar_Absyn_Syntax.v b.FStar_Absyn_Syntax.v)
end
| _50_701 -> begin
false
end)))) then begin
None
end else begin
Some ((FStar_Util.Inl (a), (Prims.snd hd)))
end
end
| FStar_Util.Inr ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_bvar (x); FStar_Absyn_Syntax.tk = _50_709; FStar_Absyn_Syntax.pos = _50_707; FStar_Absyn_Syntax.fvs = _50_705; FStar_Absyn_Syntax.uvs = _50_703}) -> begin
if (FStar_All.pipe_right seen (FStar_Util.for_some (fun _50_19 -> (match (_50_19) with
| (FStar_Util.Inr (y), _50_718) -> begin
(FStar_Absyn_Syntax.bvd_eq x.FStar_Absyn_Syntax.v y.FStar_Absyn_Syntax.v)
end
| _50_721 -> begin
false
end)))) then begin
None
end else begin
Some ((FStar_Util.Inr (x), (Prims.snd hd)))
end
end
| _50_723 -> begin
None
end)))

# 541 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec pat_vars : FStar_Tc_Env.env  ->  ((((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t, ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.withinfo_t) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list  ->  ((FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) Prims.list  ->  FStar_Absyn_Syntax.binders Prims.option = (fun env seen args -> (match (args) with
| [] -> begin
Some ((FStar_List.rev seen))
end
| hd::rest -> begin
(match ((pat_var_opt env seen hd)) with
| None -> begin
(let _50_732 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_581 = (FStar_Absyn_Print.arg_to_string hd)
in (FStar_Util.print1 "Not a pattern: %s\n" _152_581))
end else begin
()
end
in None)
end
| Some (x) -> begin
(pat_vars env ((x)::seen) rest)
end)
end))

# 549 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let destruct_flex_t = (fun t -> (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(t, uv, k, [])
end
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (uv, k); FStar_Absyn_Syntax.tk = _50_748; FStar_Absyn_Syntax.pos = _50_746; FStar_Absyn_Syntax.fvs = _50_744; FStar_Absyn_Syntax.uvs = _50_742}, args) -> begin
(t, uv, k, args)
end
| _50_758 -> begin
(FStar_All.failwith "Not a flex-uvar")
end))

# 554 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let destruct_flex_e = (fun e -> (match (e.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Exp_uvar (uv, k) -> begin
(e, uv, k, [])
end
| FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (uv, k); FStar_Absyn_Syntax.tk = _50_771; FStar_Absyn_Syntax.pos = _50_769; FStar_Absyn_Syntax.fvs = _50_767; FStar_Absyn_Syntax.uvs = _50_765}, args) -> begin
(e, uv, k, args)
end
| _50_781 -> begin
(FStar_All.failwith "Not a flex-uvar")
end))

# 559 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let destruct_flex_pattern = (fun env t -> (let _50_788 = (destruct_flex_t t)
in (match (_50_788) with
| (t, uv, k, args) -> begin
(match ((pat_vars env [] args)) with
| Some (vars) -> begin
((t, uv, k, args), Some (vars))
end
| _50_792 -> begin
((t, uv, k, args), None)
end)
end)))

# 620 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type match_result =
| MisMatch
| HeadMatch
| FullMatch

# 621 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_MisMatch : match_result  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| MisMatch -> begin
true
end
| _ -> begin
false
end))

# 622 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_HeadMatch : match_result  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| HeadMatch -> begin
true
end
| _ -> begin
false
end))

# 623 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_FullMatch : match_result  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| FullMatch -> begin
true
end
| _ -> begin
false
end))

# 625 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let head_match : match_result  ->  match_result = (fun _50_20 -> (match (_50_20) with
| MisMatch -> begin
MisMatch
end
| _50_796 -> begin
HeadMatch
end))

# 629 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec head_matches : (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  match_result = (fun t1 t2 -> (match ((let _152_598 = (let _152_595 = (FStar_Absyn_Util.unmeta_typ t1)
in _152_595.FStar_Absyn_Syntax.n)
in (let _152_597 = (let _152_596 = (FStar_Absyn_Util.unmeta_typ t2)
in _152_596.FStar_Absyn_Syntax.n)
in (_152_598, _152_597)))) with
| (FStar_Absyn_Syntax.Typ_btvar (x), FStar_Absyn_Syntax.Typ_btvar (y)) -> begin
if (FStar_Absyn_Util.bvar_eq x y) then begin
FullMatch
end else begin
MisMatch
end
end
| (FStar_Absyn_Syntax.Typ_const (f), FStar_Absyn_Syntax.Typ_const (g)) -> begin
if (FStar_Absyn_Util.fvar_eq f g) then begin
FullMatch
end else begin
MisMatch
end
end
| ((FStar_Absyn_Syntax.Typ_btvar (_), FStar_Absyn_Syntax.Typ_const (_))) | ((FStar_Absyn_Syntax.Typ_const (_), FStar_Absyn_Syntax.Typ_btvar (_))) -> begin
MisMatch
end
| (FStar_Absyn_Syntax.Typ_refine (x, _50_825), FStar_Absyn_Syntax.Typ_refine (y, _50_830)) -> begin
(let _152_599 = (head_matches x.FStar_Absyn_Syntax.sort y.FStar_Absyn_Syntax.sort)
in (FStar_All.pipe_right _152_599 head_match))
end
| (FStar_Absyn_Syntax.Typ_refine (x, _50_836), _50_840) -> begin
(let _152_600 = (head_matches x.FStar_Absyn_Syntax.sort t2)
in (FStar_All.pipe_right _152_600 head_match))
end
| (_50_843, FStar_Absyn_Syntax.Typ_refine (x, _50_846)) -> begin
(let _152_601 = (head_matches t1 x.FStar_Absyn_Syntax.sort)
in (FStar_All.pipe_right _152_601 head_match))
end
| (FStar_Absyn_Syntax.Typ_fun (_50_851), FStar_Absyn_Syntax.Typ_fun (_50_854)) -> begin
HeadMatch
end
| (FStar_Absyn_Syntax.Typ_app (head, _50_859), FStar_Absyn_Syntax.Typ_app (head', _50_864)) -> begin
(head_matches head head')
end
| (FStar_Absyn_Syntax.Typ_app (head, _50_870), _50_874) -> begin
(head_matches head t2)
end
| (_50_877, FStar_Absyn_Syntax.Typ_app (head, _50_880)) -> begin
(head_matches t1 head)
end
| (FStar_Absyn_Syntax.Typ_uvar (uv, _50_886), FStar_Absyn_Syntax.Typ_uvar (uv', _50_891)) -> begin
if (FStar_Unionfind.equivalent uv uv') then begin
FullMatch
end else begin
MisMatch
end
end
| (_50_896, FStar_Absyn_Syntax.Typ_lam (_50_898)) -> begin
HeadMatch
end
| _50_902 -> begin
MisMatch
end))

# 655 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let head_matches_delta : FStar_Tc_Env.env  ->  worklist  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (match_result * ((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) Prims.option) = (fun env wl t1 t2 -> (let success = (fun d r t1 t2 -> (r, if (d > 0) then begin
Some ((t1, t2))
end else begin
None
end))
in (let fail = (fun _50_913 -> (match (()) with
| () -> begin
(MisMatch, None)
end))
in (let rec aux = (fun d t1 t2 -> (match ((head_matches t1 t2)) with
| MisMatch -> begin
if (d = 2) then begin
(fail ())
end else begin
if (d = 1) then begin
(let t1' = (normalize_refinement ((FStar_Tc_Normalize.UnfoldOpaque)::[]) env wl t1)
in (let t2' = (normalize_refinement ((FStar_Tc_Normalize.UnfoldOpaque)::[]) env wl t2)
in (aux 2 t1' t2')))
end else begin
(let t1 = (normalize_refinement [] env wl t1)
in (let t2 = (normalize_refinement [] env wl t2)
in (aux (d + 1) t1 t2)))
end
end
end
| r -> begin
(success d r t1 t2)
end))
in (aux 0 t1 t2)))))

# 672 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let decompose_binder = (fun bs v_ktec rebuild_base -> (let fail = (fun _50_929 -> (match (()) with
| () -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (let rebuild = (fun ktecs -> (let rec aux = (fun new_bs bs ktecs -> (match ((bs, ktecs)) with
| ([], ktec::[]) -> begin
(rebuild_base (FStar_List.rev new_bs) ktec)
end
| ((FStar_Util.Inl (a), imp)::rest, FStar_Absyn_Syntax.K (k)::rest') -> begin
(aux (((FStar_Util.Inl ((let _50_951 = a
in {FStar_Absyn_Syntax.v = _50_951.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.sort = k; FStar_Absyn_Syntax.p = _50_951.FStar_Absyn_Syntax.p})), imp))::new_bs) rest rest')
end
| ((FStar_Util.Inr (x), imp)::rest, FStar_Absyn_Syntax.T (t, _50_962)::rest') -> begin
(aux (((FStar_Util.Inr ((let _50_967 = x
in {FStar_Absyn_Syntax.v = _50_967.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.sort = t; FStar_Absyn_Syntax.p = _50_967.FStar_Absyn_Syntax.p})), imp))::new_bs) rest rest')
end
| _50_970 -> begin
(fail ())
end))
in (aux [] bs ktecs)))
in (let rec mk_b_ktecs = (fun _50_974 _50_21 -> (match (_50_974) with
| (binders, b_ktecs) -> begin
(match (_50_21) with
| [] -> begin
(FStar_List.rev (((None, COVARIANT, v_ktec))::b_ktecs))
end
| hd::rest -> begin
(let bopt = if (FStar_Absyn_Syntax.is_null_binder hd) then begin
None
end else begin
Some (hd)
end
in (let b_ktec = (match ((Prims.fst hd)) with
| FStar_Util.Inl (a) -> begin
(bopt, CONTRAVARIANT, FStar_Absyn_Syntax.K (a.FStar_Absyn_Syntax.sort))
end
| FStar_Util.Inr (x) -> begin
(bopt, CONTRAVARIANT, FStar_Absyn_Syntax.T ((x.FStar_Absyn_Syntax.sort, Some (FStar_Absyn_Syntax.ktype))))
end)
in (let binders' = (match (bopt) with
| None -> begin
binders
end
| Some (hd) -> begin
(FStar_List.append binders ((hd)::[]))
end)
in (mk_b_ktecs (binders', (b_ktec)::b_ktecs) rest))))
end)
end))
in (let _152_655 = (mk_b_ktecs ([], []) bs)
in (rebuild, _152_655))))))

# 695 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec decompose_kind : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.knd  ->  ((FStar_Absyn_Syntax.ktec Prims.list  ->  FStar_Absyn_Syntax.knd) * (FStar_Absyn_Syntax.binder Prims.option * variance * FStar_Absyn_Syntax.ktec) Prims.list) = (fun env k -> (let fail = (fun _50_993 -> (match (()) with
| () -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (let k0 = k
in (let k = (FStar_Absyn_Util.compress_kind k)
in (match (k.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Kind_type) | (FStar_Absyn_Syntax.Kind_effect) -> begin
(let rebuild = (fun _50_22 -> (match (_50_22) with
| [] -> begin
k
end
| _50_1001 -> begin
(fail ())
end))
in (rebuild, []))
end
| FStar_Absyn_Syntax.Kind_arrow (bs, k) -> begin
(decompose_binder bs (FStar_Absyn_Syntax.K (k)) (fun bs _50_23 -> (match (_50_23) with
| FStar_Absyn_Syntax.K (k) -> begin
(FStar_Absyn_Syntax.mk_Kind_arrow (bs, k) k0.FStar_Absyn_Syntax.pos)
end
| _50_1012 -> begin
(fail ())
end)))
end
| FStar_Absyn_Syntax.Kind_abbrev (_50_1014, k) -> begin
(decompose_kind env k)
end
| _50_1019 -> begin
(FStar_All.failwith "Impossible")
end)))))

# 718 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec decompose_typ = (fun env t -> (let t = (FStar_Absyn_Util.unmeta_typ t)
in (let matches = (fun t' -> ((head_matches t t') <> MisMatch))
in (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_app (hd, args) -> begin
(let rebuild = (fun args' -> (let args = (FStar_List.map2 (fun x y -> (match ((x, y)) with
| ((FStar_Util.Inl (_50_1034), imp), FStar_Absyn_Syntax.T (t, _50_1040)) -> begin
(FStar_Util.Inl (t), imp)
end
| ((FStar_Util.Inr (_50_1045), imp), FStar_Absyn_Syntax.E (e)) -> begin
(FStar_Util.Inr (e), imp)
end
| _50_1053 -> begin
(FStar_All.failwith "Bad reconstruction")
end)) args args')
in (FStar_Absyn_Syntax.mk_Typ_app (hd, args) None t.FStar_Absyn_Syntax.pos)))
in (let b_ktecs = (FStar_All.pipe_right args (FStar_List.map (fun _50_24 -> (match (_50_24) with
| (FStar_Util.Inl (t), _50_1059) -> begin
(None, INVARIANT, FStar_Absyn_Syntax.T ((t, None)))
end
| (FStar_Util.Inr (e), _50_1064) -> begin
(None, INVARIANT, FStar_Absyn_Syntax.E (e))
end))))
in (rebuild, matches, b_ktecs)))
end
| FStar_Absyn_Syntax.Typ_fun (bs, c) -> begin
(let _50_1079 = (decompose_binder bs (FStar_Absyn_Syntax.C (c)) (fun bs _50_25 -> (match (_50_25) with
| FStar_Absyn_Syntax.C (c) -> begin
(FStar_Absyn_Syntax.mk_Typ_fun (bs, c) None t.FStar_Absyn_Syntax.pos)
end
| _50_1076 -> begin
(FStar_All.failwith "Bad reconstruction")
end)))
in (match (_50_1079) with
| (rebuild, b_ktecs) -> begin
(rebuild, matches, b_ktecs)
end))
end
| _50_1081 -> begin
(let rebuild = (fun _50_26 -> (match (_50_26) with
| [] -> begin
t
end
| _50_1085 -> begin
(FStar_All.failwith "Bad reconstruction")
end))
in (rebuild, (fun t -> true), []))
end))))

# 750 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let un_T : FStar_Absyn_Syntax.ktec  ->  FStar_Absyn_Syntax.typ = (fun _50_27 -> (match (_50_27) with
| FStar_Absyn_Syntax.T (x, _50_1091) -> begin
x
end
| _50_1095 -> begin
(FStar_All.failwith "impossible")
end))

# 753 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let arg_of_ktec : FStar_Absyn_Syntax.ktec  ->  (((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax, (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Util.either * FStar_Absyn_Syntax.arg_qualifier Prims.option) = (fun _50_28 -> (match (_50_28) with
| FStar_Absyn_Syntax.T (t, _50_1099) -> begin
(FStar_Absyn_Syntax.targ t)
end
| FStar_Absyn_Syntax.E (e) -> begin
(FStar_Absyn_Syntax.varg e)
end
| _50_1105 -> begin
(FStar_All.failwith "Impossible")
end))

# 758 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let imitation_sub_probs = (fun orig env scope ps qs -> (let r = (p_loc orig)
in (let rel = (p_rel orig)
in (let sub_prob = (fun scope args q -> (match (q) with
| (_50_1118, variance, FStar_Absyn_Syntax.K (ki)) -> begin
(let _50_1125 = (new_kvar r scope)
in (match (_50_1125) with
| (gi_xs, gi) -> begin
(let gi_ps = (FStar_Absyn_Syntax.mk_Kind_uvar (gi, args) r)
in (let _152_738 = (let _152_737 = (mk_problem scope orig gi_ps (vary_rel rel variance) ki None "kind subterm")
in (FStar_All.pipe_left (fun _152_736 -> KProb (_152_736)) _152_737))
in (FStar_Absyn_Syntax.K (gi_xs), _152_738)))
end))
end
| (_50_1128, variance, FStar_Absyn_Syntax.T (ti, kopt)) -> begin
(let k = (match (kopt) with
| Some (k) -> begin
k
end
| None -> begin
(FStar_Tc_Recheck.recompute_kind ti)
end)
in (let _50_1141 = (new_tvar r scope k)
in (match (_50_1141) with
| (gi_xs, gi) -> begin
(let gi_ps = (FStar_Absyn_Syntax.mk_Typ_app' (gi, args) None r)
in (let _152_741 = (let _152_740 = (mk_problem scope orig gi_ps (vary_rel rel variance) ti None "type subterm")
in (FStar_All.pipe_left (fun _152_739 -> TProb (_152_739)) _152_740))
in (FStar_Absyn_Syntax.T ((gi_xs, Some (k))), _152_741)))
end)))
end
| (_50_1144, variance, FStar_Absyn_Syntax.E (ei)) -> begin
(let t = (FStar_Tc_Recheck.recompute_typ ei)
in (let _50_1152 = (new_evar r scope t)
in (match (_50_1152) with
| (gi_xs, gi) -> begin
(let gi_ps = (FStar_Absyn_Syntax.mk_Exp_app' (gi, args) (Some (t)) r)
in (let _152_744 = (let _152_743 = (mk_problem scope orig gi_ps (vary_rel rel variance) ei None "expression subterm")
in (FStar_All.pipe_left (fun _152_742 -> EProb (_152_742)) _152_743))
in (FStar_Absyn_Syntax.E (gi_xs), _152_744)))
end)))
end
| (_50_1155, _50_1157, FStar_Absyn_Syntax.C (_50_1159)) -> begin
(FStar_All.failwith "impos")
end))
in (let rec aux = (fun scope args qs -> (match (qs) with
| [] -> begin
([], [], FStar_Absyn_Util.t_true)
end
| q::qs -> begin
(let _50_1235 = (match (q) with
| (bopt, variance, FStar_Absyn_Syntax.C ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Total (ti); FStar_Absyn_Syntax.tk = _50_1179; FStar_Absyn_Syntax.pos = _50_1177; FStar_Absyn_Syntax.fvs = _50_1175; FStar_Absyn_Syntax.uvs = _50_1173})) -> begin
(match ((sub_prob scope args (bopt, variance, FStar_Absyn_Syntax.T ((ti, Some (FStar_Absyn_Syntax.ktype)))))) with
| (FStar_Absyn_Syntax.T (gi_xs, _50_1187), prob) -> begin
(let _152_753 = (let _152_752 = (FStar_Absyn_Syntax.mk_Total gi_xs)
in (FStar_All.pipe_left (fun _152_751 -> FStar_Absyn_Syntax.C (_152_751)) _152_752))
in (_152_753, (prob)::[]))
end
| _50_1193 -> begin
(FStar_All.failwith "impossible")
end)
end
| (_50_1195, _50_1197, FStar_Absyn_Syntax.C ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Comp (c); FStar_Absyn_Syntax.tk = _50_1205; FStar_Absyn_Syntax.pos = _50_1203; FStar_Absyn_Syntax.fvs = _50_1201; FStar_Absyn_Syntax.uvs = _50_1199})) -> begin
(let components = (FStar_All.pipe_right c.FStar_Absyn_Syntax.effect_args (FStar_List.map (fun _50_29 -> (match (_50_29) with
| (FStar_Util.Inl (t), _50_1215) -> begin
(None, INVARIANT, FStar_Absyn_Syntax.T ((t, None)))
end
| (FStar_Util.Inr (e), _50_1220) -> begin
(None, INVARIANT, FStar_Absyn_Syntax.E (e))
end))))
in (let components = ((None, COVARIANT, FStar_Absyn_Syntax.T ((c.FStar_Absyn_Syntax.result_typ, Some (FStar_Absyn_Syntax.ktype)))))::components
in (let _50_1226 = (let _152_755 = (FStar_List.map (sub_prob scope args) components)
in (FStar_All.pipe_right _152_755 FStar_List.unzip))
in (match (_50_1226) with
| (ktecs, sub_probs) -> begin
(let gi_xs = (let _152_760 = (let _152_759 = (let _152_756 = (FStar_List.hd ktecs)
in (FStar_All.pipe_right _152_756 un_T))
in (let _152_758 = (let _152_757 = (FStar_List.tl ktecs)
in (FStar_All.pipe_right _152_757 (FStar_List.map arg_of_ktec)))
in {FStar_Absyn_Syntax.effect_name = c.FStar_Absyn_Syntax.effect_name; FStar_Absyn_Syntax.result_typ = _152_759; FStar_Absyn_Syntax.effect_args = _152_758; FStar_Absyn_Syntax.flags = c.FStar_Absyn_Syntax.flags}))
in (FStar_All.pipe_left FStar_Absyn_Syntax.mk_Comp _152_760))
in (FStar_Absyn_Syntax.C (gi_xs), sub_probs))
end))))
end
| _50_1229 -> begin
(let _50_1232 = (sub_prob scope args q)
in (match (_50_1232) with
| (ktec, prob) -> begin
(ktec, (prob)::[])
end))
end)
in (match (_50_1235) with
| (ktec, probs) -> begin
(let _50_1248 = (match (q) with
| (Some (b), _50_1239, _50_1241) -> begin
(let _152_762 = (let _152_761 = (FStar_Absyn_Util.arg_of_non_null_binder b)
in (_152_761)::args)
in (Some (b), (b)::scope, _152_762))
end
| _50_1244 -> begin
(None, scope, args)
end)
in (match (_50_1248) with
| (bopt, scope, args) -> begin
(let _50_1252 = (aux scope args qs)
in (match (_50_1252) with
| (sub_probs, ktecs, f) -> begin
(let f = (match (bopt) with
| None -> begin
(let _152_765 = (let _152_764 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (f)::_152_764)
in (FStar_Absyn_Util.mk_conj_l _152_765))
end
| Some (b) -> begin
(let _152_769 = (let _152_768 = (FStar_Absyn_Util.close_forall ((b)::[]) f)
in (let _152_767 = (FStar_All.pipe_right probs (FStar_List.map (fun prob -> (FStar_All.pipe_right (p_guard prob) Prims.fst))))
in (_152_768)::_152_767))
in (FStar_Absyn_Util.mk_conj_l _152_769))
end)
in ((FStar_List.append probs sub_probs), (ktec)::ktecs, f))
end))
end))
end))
end))
in (aux scope ps qs))))))

# 1029 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type slack =
{lower : (FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.typ); upper : (FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.typ); flag : Prims.bool FStar_ST.ref}

# 1029 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Mkslack : slack  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkslack"))))

# 1034 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let fix_slack_uv : (FStar_Absyn_Syntax.typ FStar_Absyn_Syntax.uvar_basis FStar_Unionfind.uvar * (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax)  ->  Prims.bool  ->  Prims.unit = (fun _50_1265 mul -> (match (_50_1265) with
| (uv, k) -> begin
(let inst = if mul then begin
(FStar_Absyn_Util.close_for_kind FStar_Absyn_Util.t_true k)
end else begin
(FStar_Absyn_Util.close_for_kind FStar_Absyn_Util.t_false k)
end
in (FStar_Absyn_Util.unchecked_unify uv inst))
end))

# 1040 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let fix_slack_vars : (Prims.bool * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) Prims.list  ->  Prims.unit = (fun slack -> (FStar_All.pipe_right slack (FStar_List.iter (fun _50_1271 -> (match (_50_1271) with
| (mul, s) -> begin
(match ((let _152_787 = (FStar_Absyn_Util.compress_typ s)
in _152_787.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_uvar (uv, k) -> begin
(fix_slack_uv (uv, k) mul)
end
| _50_1277 -> begin
()
end)
end)))))

# 1045 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let fix_slack : slack  ->  FStar_Absyn_Syntax.typ = (fun slack -> (let _50_1285 = (FStar_All.pipe_left destruct_flex_t (Prims.snd slack.lower))
in (match (_50_1285) with
| (_50_1280, ul, kl, _50_1284) -> begin
(let _50_1292 = (FStar_All.pipe_left destruct_flex_t (Prims.snd slack.upper))
in (match (_50_1292) with
| (_50_1287, uh, kh, _50_1291) -> begin
(let _50_1293 = (fix_slack_uv (ul, kl) false)
in (let _50_1295 = (fix_slack_uv (uh, kh) true)
in (let _50_1297 = (FStar_ST.op_Colon_Equals slack.flag true)
in (FStar_Absyn_Util.mk_conj (Prims.fst slack.lower) (Prims.fst slack.upper)))))
end))
end)))

# 1053 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_slack_var : FStar_Tc_Env.env  ->  slack  ->  (((FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax * (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) * FStar_Absyn_Syntax.binders) = (fun env slack -> (let xs = (let _152_795 = (let _152_794 = (destruct_flex_pattern env (Prims.snd slack.lower))
in (FStar_All.pipe_right _152_794 Prims.snd))
in (FStar_All.pipe_right _152_795 FStar_Util.must))
in (let _152_796 = (new_tvar (Prims.fst slack.lower).FStar_Absyn_Syntax.pos xs FStar_Absyn_Syntax.ktype)
in (_152_796, xs))))

# 1057 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_slack_formula = (fun p env wl xs low high -> (let _50_1310 = (new_tvar p xs FStar_Absyn_Syntax.ktype)
in (match (_50_1310) with
| (low_var, uv1) -> begin
(let wl = (add_slack_add uv1 wl)
in (let _50_1314 = (new_tvar p xs FStar_Absyn_Syntax.ktype)
in (match (_50_1314) with
| (high_var, uv2) -> begin
(let wl = (add_slack_mul uv2 wl)
in (let low = (match (low) with
| None -> begin
(FStar_Absyn_Util.mk_disj FStar_Absyn_Util.t_false low_var)
end
| Some (f) -> begin
(FStar_Absyn_Util.mk_disj f low_var)
end)
in (let high = (match (high) with
| None -> begin
(FStar_Absyn_Util.mk_conj FStar_Absyn_Util.t_true high_var)
end
| Some (f) -> begin
(FStar_Absyn_Util.mk_conj f high_var)
end)
in (let _152_806 = (let _152_805 = (let _152_804 = (let _152_803 = (FStar_Util.mk_ref false)
in (low, high, _152_803))
in FStar_Absyn_Syntax.Meta_slack_formula (_152_804))
in (FStar_Absyn_Syntax.mk_Typ_meta _152_805))
in (_152_806, wl)))))
end)))
end)))

# 1081 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let destruct_slack : FStar_Tc_Env.env  ->  worklist  ->  FStar_Absyn_Syntax.typ  ->  (FStar_Absyn_Syntax.typ, slack) FStar_Util.either = (fun env wl phi -> (let rec destruct = (fun conn_lid mk_conn phi -> (match (phi.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_const (tc); FStar_Absyn_Syntax.tk = _50_1338; FStar_Absyn_Syntax.pos = _50_1336; FStar_Absyn_Syntax.fvs = _50_1334; FStar_Absyn_Syntax.uvs = _50_1332}, (FStar_Util.Inl (lhs), _50_1350)::(FStar_Util.Inl (rhs), _50_1345)::[]) when (FStar_Ident.lid_equals tc.FStar_Absyn_Syntax.v conn_lid) -> begin
(let rhs = (compress env wl rhs)
in (match (rhs.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Typ_uvar (_)) | (FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _)) -> begin
Some ((lhs, rhs))
end
| _50_1376 -> begin
(match ((destruct conn_lid mk_conn rhs)) with
| None -> begin
None
end
| Some (rest, uvar) -> begin
(let _152_830 = (let _152_829 = (mk_conn lhs rest)
in (_152_829, uvar))
in Some (_152_830))
end)
end))
end
| _50_1383 -> begin
None
end))
in (let phi = (FStar_Absyn_Util.compress_typ phi)
in (match (phi.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_meta (FStar_Absyn_Syntax.Meta_slack_formula (phi1, phi2, flag)) -> begin
if (FStar_ST.read flag) then begin
(let _152_831 = (FStar_Absyn_Util.unmeta_typ phi)
in FStar_Util.Inl (_152_831))
end else begin
(let low = (let _152_832 = (compress env wl phi1)
in (FStar_All.pipe_left (destruct FStar_Absyn_Const.or_lid FStar_Absyn_Util.mk_disj) _152_832))
in (let hi = (let _152_833 = (compress env wl phi2)
in (FStar_All.pipe_left (destruct FStar_Absyn_Const.and_lid FStar_Absyn_Util.mk_disj) _152_833))
in (match ((low, hi)) with
| (None, None) -> begin
(let _50_1396 = (FStar_ST.op_Colon_Equals flag true)
in (let _152_834 = (FStar_Absyn_Util.unmeta_typ phi)
in FStar_Util.Inl (_152_834)))
end
| ((Some (_), None)) | ((None, Some (_))) -> begin
(FStar_All.failwith "Impossible")
end
| (Some (l), Some (u)) -> begin
FStar_Util.Inr ({lower = l; upper = u; flag = flag})
end)))
end
end
| _50_1414 -> begin
FStar_Util.Inl (phi)
end))))

# 1121 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec eq_typ : FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ  ->  Prims.bool = (fun t1 t2 -> (let t1 = (FStar_Absyn_Util.compress_typ t1)
in (let t2 = (FStar_Absyn_Util.compress_typ t2)
in (match ((t1.FStar_Absyn_Syntax.n, t2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Typ_btvar (a), FStar_Absyn_Syntax.Typ_btvar (b)) -> begin
(FStar_Absyn_Util.bvar_eq a b)
end
| (FStar_Absyn_Syntax.Typ_const (f), FStar_Absyn_Syntax.Typ_const (g)) -> begin
(FStar_Absyn_Util.fvar_eq f g)
end
| (FStar_Absyn_Syntax.Typ_uvar (u1, _50_1431), FStar_Absyn_Syntax.Typ_uvar (u2, _50_1436)) -> begin
(FStar_Unionfind.equivalent u1 u2)
end
| (FStar_Absyn_Syntax.Typ_app (h1, args1), FStar_Absyn_Syntax.Typ_app (h2, args2)) -> begin
((eq_typ h1 h2) && (eq_args args1 args2))
end
| _50_1450 -> begin
false
end))))
and eq_exp : FStar_Absyn_Syntax.exp  ->  FStar_Absyn_Syntax.exp  ->  Prims.bool = (fun e1 e2 -> (let e1 = (FStar_Absyn_Util.compress_exp e1)
in (let e2 = (FStar_Absyn_Util.compress_exp e2)
in (match ((e1.FStar_Absyn_Syntax.n, e2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_bvar (a), FStar_Absyn_Syntax.Exp_bvar (b)) -> begin
(FStar_Absyn_Util.bvar_eq a b)
end
| (FStar_Absyn_Syntax.Exp_fvar (f, _50_1462), FStar_Absyn_Syntax.Exp_fvar (g, _50_1467)) -> begin
(FStar_Absyn_Util.fvar_eq f g)
end
| (FStar_Absyn_Syntax.Exp_constant (c), FStar_Absyn_Syntax.Exp_constant (d)) -> begin
(c = d)
end
| (FStar_Absyn_Syntax.Exp_app (h1, args1), FStar_Absyn_Syntax.Exp_app (h2, args2)) -> begin
((eq_exp h1 h2) && (eq_args args1 args2))
end
| _50_1486 -> begin
false
end))))
and eq_args : FStar_Absyn_Syntax.args  ->  FStar_Absyn_Syntax.args  ->  Prims.bool = (fun a1 a2 -> if ((FStar_List.length a1) = (FStar_List.length a2)) then begin
(FStar_List.forall2 (fun a1 a2 -> (match ((a1, a2)) with
| ((FStar_Util.Inl (t), _50_1494), (FStar_Util.Inl (s), _50_1499)) -> begin
(eq_typ t s)
end
| ((FStar_Util.Inr (e), _50_1505), (FStar_Util.Inr (f), _50_1510)) -> begin
(eq_exp e f)
end
| _50_1514 -> begin
false
end)) a1 a2)
end else begin
false
end)

# 1150 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type flex_t =
(FStar_Absyn_Syntax.typ * FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd * FStar_Absyn_Syntax.args)

# 1151 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type im_or_proj_t =
((FStar_Absyn_Syntax.uvar_t * FStar_Absyn_Syntax.knd) * FStar_Absyn_Syntax.arg Prims.list * FStar_Absyn_Syntax.binders * ((FStar_Absyn_Syntax.ktec Prims.list  ->  FStar_Absyn_Syntax.typ) * (FStar_Absyn_Syntax.typ  ->  Prims.bool) * (FStar_Absyn_Syntax.binder Prims.option * variance * FStar_Absyn_Syntax.ktec) Prims.list))

# 1153 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rigid_rigid : Prims.int = 0

# 1154 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let flex_rigid_eq : Prims.int = 1

# 1155 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let flex_refine_inner : Prims.int = 2

# 1156 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let flex_refine : Prims.int = 3

# 1157 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let flex_rigid : Prims.int = 4

# 1158 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rigid_flex : Prims.int = 5

# 1159 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let refine_flex : Prims.int = 6

# 1160 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let flex_flex : Prims.int = 7

# 1161 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let compress_prob : worklist  ->  prob  ->  prob = (fun wl p -> (match (p) with
| KProb (p) -> begin
(let _152_864 = (let _50_1519 = p
in (let _152_862 = (compress_k wl.tcenv wl p.lhs)
in (let _152_861 = (compress_k wl.tcenv wl p.rhs)
in {lhs = _152_862; relation = _50_1519.relation; rhs = _152_861; element = _50_1519.element; logical_guard = _50_1519.logical_guard; scope = _50_1519.scope; reason = _50_1519.reason; loc = _50_1519.loc; rank = _50_1519.rank})))
in (FStar_All.pipe_right _152_864 (fun _152_863 -> KProb (_152_863))))
end
| TProb (p) -> begin
(let _152_868 = (let _50_1523 = p
in (let _152_866 = (compress wl.tcenv wl p.lhs)
in (let _152_865 = (compress wl.tcenv wl p.rhs)
in {lhs = _152_866; relation = _50_1523.relation; rhs = _152_865; element = _50_1523.element; logical_guard = _50_1523.logical_guard; scope = _50_1523.scope; reason = _50_1523.reason; loc = _50_1523.loc; rank = _50_1523.rank})))
in (FStar_All.pipe_right _152_868 (fun _152_867 -> TProb (_152_867))))
end
| EProb (p) -> begin
(let _152_872 = (let _50_1527 = p
in (let _152_870 = (compress_e wl.tcenv wl p.lhs)
in (let _152_869 = (compress_e wl.tcenv wl p.rhs)
in {lhs = _152_870; relation = _50_1527.relation; rhs = _152_869; element = _50_1527.element; logical_guard = _50_1527.logical_guard; scope = _50_1527.scope; reason = _50_1527.reason; loc = _50_1527.loc; rank = _50_1527.rank})))
in (FStar_All.pipe_right _152_872 (fun _152_871 -> EProb (_152_871))))
end
| CProb (_50_1530) -> begin
p
end))

# 1167 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rank : worklist  ->  prob  ->  (Prims.int * prob) = (fun wl prob -> (let prob = (let _152_877 = (compress_prob wl prob)
in (FStar_All.pipe_right _152_877 maybe_invert_p))
in (match (prob) with
| KProb (kp) -> begin
(let rank = (match ((kp.lhs.FStar_Absyn_Syntax.n, kp.rhs.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Kind_uvar (_50_1538), FStar_Absyn_Syntax.Kind_uvar (_50_1541)) -> begin
flex_flex
end
| (FStar_Absyn_Syntax.Kind_uvar (_50_1545), _50_1548) -> begin
if (kp.relation = EQ) then begin
flex_rigid_eq
end else begin
flex_rigid
end
end
| (_50_1551, FStar_Absyn_Syntax.Kind_uvar (_50_1553)) -> begin
if (kp.relation = EQ) then begin
flex_rigid_eq
end else begin
rigid_flex
end
end
| (_50_1557, _50_1559) -> begin
rigid_rigid
end)
in (let _152_879 = (FStar_All.pipe_right (let _50_1562 = kp
in {lhs = _50_1562.lhs; relation = _50_1562.relation; rhs = _50_1562.rhs; element = _50_1562.element; logical_guard = _50_1562.logical_guard; scope = _50_1562.scope; reason = _50_1562.reason; loc = _50_1562.loc; rank = Some (rank)}) (fun _152_878 -> KProb (_152_878)))
in (rank, _152_879)))
end
| TProb (tp) -> begin
(let _50_1569 = (FStar_Absyn_Util.head_and_args tp.lhs)
in (match (_50_1569) with
| (lh, _50_1568) -> begin
(let _50_1573 = (FStar_Absyn_Util.head_and_args tp.rhs)
in (match (_50_1573) with
| (rh, _50_1572) -> begin
(let _50_1629 = (match ((lh.FStar_Absyn_Syntax.n, rh.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Typ_uvar (_50_1575), FStar_Absyn_Syntax.Typ_uvar (_50_1578)) -> begin
(flex_flex, tp)
end
| ((FStar_Absyn_Syntax.Typ_uvar (_), _)) | ((_, FStar_Absyn_Syntax.Typ_uvar (_))) when (tp.relation = EQ) -> begin
(flex_rigid_eq, tp)
end
| (FStar_Absyn_Syntax.Typ_uvar (_50_1594), _50_1597) -> begin
(let _50_1601 = (base_and_refinement wl.tcenv wl tp.rhs)
in (match (_50_1601) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(flex_rigid, tp)
end
| _50_1604 -> begin
(let rank = if (is_top_level_prob prob) then begin
flex_refine
end else begin
flex_refine_inner
end
in (let _152_881 = (let _50_1606 = tp
in (let _152_880 = (force_refinement (b, ref_opt))
in {lhs = _50_1606.lhs; relation = _50_1606.relation; rhs = _152_880; element = _50_1606.element; logical_guard = _50_1606.logical_guard; scope = _50_1606.scope; reason = _50_1606.reason; loc = _50_1606.loc; rank = _50_1606.rank}))
in (rank, _152_881)))
end)
end))
end
| (_50_1609, FStar_Absyn_Syntax.Typ_uvar (_50_1611)) -> begin
(let _50_1616 = (base_and_refinement wl.tcenv wl tp.lhs)
in (match (_50_1616) with
| (b, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(rigid_flex, tp)
end
| _50_1619 -> begin
(let _152_883 = (let _50_1620 = tp
in (let _152_882 = (force_refinement (b, ref_opt))
in {lhs = _152_882; relation = _50_1620.relation; rhs = _50_1620.rhs; element = _50_1620.element; logical_guard = _50_1620.logical_guard; scope = _50_1620.scope; reason = _50_1620.reason; loc = _50_1620.loc; rank = _50_1620.rank}))
in (refine_flex, _152_883))
end)
end))
end
| (_50_1623, _50_1625) -> begin
(rigid_rigid, tp)
end)
in (match (_50_1629) with
| (rank, tp) -> begin
(let _152_885 = (FStar_All.pipe_right (let _50_1630 = tp
in {lhs = _50_1630.lhs; relation = _50_1630.relation; rhs = _50_1630.rhs; element = _50_1630.element; logical_guard = _50_1630.logical_guard; scope = _50_1630.scope; reason = _50_1630.reason; loc = _50_1630.loc; rank = Some (rank)}) (fun _152_884 -> TProb (_152_884)))
in (rank, _152_885))
end))
end))
end))
end
| EProb (ep) -> begin
(let _50_1637 = (FStar_Absyn_Util.head_and_args_e ep.lhs)
in (match (_50_1637) with
| (lh, _50_1636) -> begin
(let _50_1641 = (FStar_Absyn_Util.head_and_args_e ep.rhs)
in (match (_50_1641) with
| (rh, _50_1640) -> begin
(let rank = (match ((lh.FStar_Absyn_Syntax.n, rh.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_uvar (_50_1643), FStar_Absyn_Syntax.Exp_uvar (_50_1646)) -> begin
flex_flex
end
| ((FStar_Absyn_Syntax.Exp_uvar (_), _)) | ((_, FStar_Absyn_Syntax.Exp_uvar (_))) -> begin
flex_rigid_eq
end
| (_50_1662, _50_1664) -> begin
rigid_rigid
end)
in (let _152_887 = (FStar_All.pipe_right (let _50_1667 = ep
in {lhs = _50_1667.lhs; relation = _50_1667.relation; rhs = _50_1667.rhs; element = _50_1667.element; logical_guard = _50_1667.logical_guard; scope = _50_1667.scope; reason = _50_1667.reason; loc = _50_1667.loc; rank = Some (rank)}) (fun _152_886 -> EProb (_152_886)))
in (rank, _152_887)))
end))
end))
end
| CProb (cp) -> begin
(let _152_889 = (FStar_All.pipe_right (let _50_1671 = cp
in {lhs = _50_1671.lhs; relation = _50_1671.relation; rhs = _50_1671.rhs; element = _50_1671.element; logical_guard = _50_1671.logical_guard; scope = _50_1671.scope; reason = _50_1671.reason; loc = _50_1671.loc; rank = Some (rigid_rigid)}) (fun _152_888 -> CProb (_152_888)))
in (rigid_rigid, _152_889))
end)))

# 1223 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let next_prob : worklist  ->  (prob Prims.option * prob Prims.list * Prims.int) = (fun wl -> (let rec aux = (fun _50_1678 probs -> (match (_50_1678) with
| (min_rank, min, out) -> begin
(match (probs) with
| [] -> begin
(min, out, min_rank)
end
| hd::tl -> begin
(let _50_1686 = (rank wl hd)
in (match (_50_1686) with
| (rank, hd) -> begin
if (rank <= flex_rigid_eq) then begin
(match (min) with
| None -> begin
(Some (hd), (FStar_List.append out tl), rank)
end
| Some (m) -> begin
(Some (hd), (FStar_List.append out ((m)::tl)), rank)
end)
end else begin
if (rank < min_rank) then begin
(match (min) with
| None -> begin
(aux (rank, Some (hd), out) tl)
end
| Some (m) -> begin
(aux (rank, Some (hd), (m)::out) tl)
end)
end else begin
(aux (min_rank, min, (hd)::out) tl)
end
end
end))
end)
end))
in (aux ((flex_flex + 1), None, []) wl.attempting)))

# 1243 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_flex_rigid : Prims.int  ->  Prims.bool = (fun rank -> ((flex_refine_inner <= rank) && (rank <= flex_rigid)))

# 1244 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let rec solve_flex_rigid_join : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) problem  ->  worklist  ->  worklist Prims.option = (fun env tp wl -> (let _50_1697 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_939 = (prob_to_string env (TProb (tp)))
in (FStar_Util.print1 "Trying to solve by joining refinements:%s\n" _152_939))
end else begin
()
end
in (let _50_1701 = (FStar_Absyn_Util.head_and_args tp.lhs)
in (match (_50_1701) with
| (u, args) -> begin
(let _50_1707 = (0, 1, 2, 3, 4)
in (match (_50_1707) with
| (ok, head_match, partial_match, fallback, failed_match) -> begin
(let max = (fun i j -> if (i < j) then begin
j
end else begin
i
end)
in (let base_types_match = (fun t1 t2 -> (let _50_1716 = (FStar_Absyn_Util.head_and_args t1)
in (match (_50_1716) with
| (h1, args1) -> begin
(let _50_1720 = (FStar_Absyn_Util.head_and_args t2)
in (match (_50_1720) with
| (h2, _50_1719) -> begin
(match ((h1.FStar_Absyn_Syntax.n, h2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Typ_const (tc1), FStar_Absyn_Syntax.Typ_const (tc2)) -> begin
if (FStar_Ident.lid_equals tc1.FStar_Absyn_Syntax.v tc2.FStar_Absyn_Syntax.v) then begin
if ((FStar_List.length args1) = 0) then begin
Some ([])
end else begin
(let _152_951 = (let _152_950 = (let _152_949 = (new_problem env t1 EQ t2 None t1.FStar_Absyn_Syntax.pos "joining refinements")
in (FStar_All.pipe_left (fun _152_948 -> TProb (_152_948)) _152_949))
in (_152_950)::[])
in Some (_152_951))
end
end else begin
None
end
end
| (FStar_Absyn_Syntax.Typ_btvar (a), FStar_Absyn_Syntax.Typ_btvar (b)) -> begin
if (FStar_Absyn_Util.bvar_eq a b) then begin
Some ([])
end else begin
None
end
end
| _50_1732 -> begin
None
end)
end))
end)))
in (let conjoin = (fun t1 t2 -> (match ((t1.FStar_Absyn_Syntax.n, t2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Typ_refine (x, phi1), FStar_Absyn_Syntax.Typ_refine (y, phi2)) -> begin
(let m = (base_types_match x.FStar_Absyn_Syntax.sort y.FStar_Absyn_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
(let phi2 = (let _152_956 = (FStar_Absyn_Util.mk_subst_one_binder (FStar_Absyn_Syntax.v_binder x) (FStar_Absyn_Syntax.v_binder y))
in (FStar_Absyn_Util.subst_typ _152_956 phi2))
in (let _152_960 = (let _152_959 = (let _152_958 = (let _152_957 = (FStar_Absyn_Util.mk_conj phi1 phi2)
in (x, _152_957))
in (FStar_Absyn_Syntax.mk_Typ_refine _152_958 (Some (FStar_Absyn_Syntax.ktype)) t1.FStar_Absyn_Syntax.pos))
in (_152_959, m))
in Some (_152_960)))
end))
end
| (_50_1751, FStar_Absyn_Syntax.Typ_refine (y, _50_1754)) -> begin
(let m = (base_types_match t1 y.FStar_Absyn_Syntax.sort)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t2, m))
end))
end
| (FStar_Absyn_Syntax.Typ_refine (x, _50_1764), _50_1768) -> begin
(let m = (base_types_match x.FStar_Absyn_Syntax.sort t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end
| _50_1775 -> begin
(let m = (base_types_match t1 t2)
in (match (m) with
| None -> begin
None
end
| Some (m) -> begin
Some ((t1, m))
end))
end))
in (let tt = u
in (match (tt.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_uvar (uv, _50_1783) -> begin
(let _50_1808 = (FStar_All.pipe_right wl.attempting (FStar_List.partition (fun _50_30 -> (match (_50_30) with
| TProb (tp) -> begin
(match (tp.rank) with
| Some (rank) when (is_flex_rigid rank) -> begin
(let _50_1794 = (FStar_Absyn_Util.head_and_args tp.lhs)
in (match (_50_1794) with
| (u', _50_1793) -> begin
(match ((let _152_962 = (compress env wl u')
in _152_962.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_uvar (uv', _50_1797) -> begin
(FStar_Unionfind.equivalent uv uv')
end
| _50_1801 -> begin
false
end)
end))
end
| _50_1803 -> begin
false
end)
end
| _50_1805 -> begin
false
end))))
in (match (_50_1808) with
| (upper_bounds, rest) -> begin
(let rec make_upper_bound = (fun _50_1812 tps -> (match (_50_1812) with
| (bound, sub_probs) -> begin
(match (tps) with
| [] -> begin
Some ((bound, sub_probs))
end
| TProb (hd)::tl -> begin
(match ((let _152_967 = (compress env wl hd.rhs)
in (conjoin bound _152_967))) with
| Some (bound, sub) -> begin
(make_upper_bound (bound, (FStar_List.append sub sub_probs)) tl)
end
| None -> begin
None
end)
end
| _50_1825 -> begin
None
end)
end))
in (match ((let _152_969 = (let _152_968 = (compress env wl tp.rhs)
in (_152_968, []))
in (make_upper_bound _152_969 upper_bounds))) with
| None -> begin
(let _50_1827 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print_string "No upper bounds\n")
end else begin
()
end
in None)
end
| Some (rhs_bound, sub_probs) -> begin
(let eq_prob = (new_problem env tp.lhs EQ rhs_bound None tp.loc "joining refinements")
in (match ((solve_t env eq_prob (let _50_1834 = wl
in {attempting = sub_probs; wl_deferred = _50_1834.wl_deferred; subst = _50_1834.subst; ctr = _50_1834.ctr; slack_vars = _50_1834.slack_vars; defer_ok = _50_1834.defer_ok; smt_ok = _50_1834.smt_ok; tcenv = _50_1834.tcenv}))) with
| Success (subst, _50_1838) -> begin
(let wl = (let _50_1841 = wl
in {attempting = rest; wl_deferred = _50_1841.wl_deferred; subst = []; ctr = _50_1841.ctr; slack_vars = _50_1841.slack_vars; defer_ok = _50_1841.defer_ok; smt_ok = _50_1841.smt_ok; tcenv = _50_1841.tcenv})
in (let wl = (solve_prob (TProb (tp)) None subst wl)
in (let _50_1847 = (FStar_List.fold_left (fun wl p -> (solve_prob' true p None [] wl)) wl upper_bounds)
in Some (wl))))
end
| _50_1850 -> begin
None
end))
end))
end))
end
| _50_1852 -> begin
(FStar_All.failwith "Impossible: Not a flex-rigid")
end)))))
end))
end))))
and solve : FStar_Tc_Env.env  ->  worklist  ->  solution = (fun env probs -> (match ((next_prob probs)) with
| (Some (hd), tl, rank) -> begin
(let probs = (let _50_1860 = probs
in {attempting = tl; wl_deferred = _50_1860.wl_deferred; subst = _50_1860.subst; ctr = _50_1860.ctr; slack_vars = _50_1860.slack_vars; defer_ok = _50_1860.defer_ok; smt_ok = _50_1860.smt_ok; tcenv = _50_1860.tcenv})
in (match (hd) with
| KProb (kp) -> begin
(solve_k' env (maybe_invert kp) probs)
end
| TProb (tp) -> begin
if ((((not (probs.defer_ok)) && (flex_refine_inner <= rank)) && (rank <= flex_rigid)) && (not ((FStar_ST.read FStar_Options.no_slack)))) then begin
(match ((solve_flex_rigid_join env tp probs)) with
| None -> begin
(solve_t' env (maybe_invert tp) probs)
end
| Some (wl) -> begin
(solve env wl)
end)
end else begin
(solve_t' env (maybe_invert tp) probs)
end
end
| EProb (ep) -> begin
(solve_e' env (maybe_invert ep) probs)
end
| CProb (cp) -> begin
(solve_c env (maybe_invert cp) probs)
end))
end
| (None, _50_1876, _50_1878) -> begin
(match (probs.wl_deferred) with
| [] -> begin
Success ((probs.subst, {carry = []; slack = probs.slack_vars}))
end
| _50_1882 -> begin
(let _50_1891 = (FStar_All.pipe_right probs.wl_deferred (FStar_List.partition (fun _50_1888 -> (match (_50_1888) with
| (c, _50_1885, _50_1887) -> begin
(c < probs.ctr)
end))))
in (match (_50_1891) with
| (attempt, rest) -> begin
(match (attempt) with
| [] -> begin
(let _152_978 = (let _152_977 = (let _152_976 = (FStar_List.map (fun _50_1897 -> (match (_50_1897) with
| (_50_1894, x, y) -> begin
(x, y)
end)) probs.wl_deferred)
in {carry = _152_976; slack = probs.slack_vars})
in (probs.subst, _152_977))
in Success (_152_978))
end
| _50_1899 -> begin
(let _152_981 = (let _50_1900 = probs
in (let _152_980 = (FStar_All.pipe_right attempt (FStar_List.map (fun _50_1907 -> (match (_50_1907) with
| (_50_1903, _50_1905, y) -> begin
y
end))))
in {attempting = _152_980; wl_deferred = rest; subst = _50_1900.subst; ctr = _50_1900.ctr; slack_vars = _50_1900.slack_vars; defer_ok = _50_1900.defer_ok; smt_ok = _50_1900.smt_ok; tcenv = _50_1900.tcenv}))
in (solve env _152_981))
end)
end))
end)
end))
and solve_binders : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.binders  ->  FStar_Absyn_Syntax.binders  ->  prob  ->  worklist  ->  (FStar_Absyn_Syntax.binders  ->  FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.subst_elt Prims.list  ->  prob)  ->  solution = (fun env bs1 bs2 orig wl rhs -> (let rec aux = (fun scope env subst xs ys -> (match ((xs, ys)) with
| ([], []) -> begin
(let rhs_prob = (rhs scope env subst)
in (let formula = (FStar_All.pipe_right (p_guard rhs_prob) Prims.fst)
in FStar_Util.Inl (((rhs_prob)::[], formula))))
end
| (((FStar_Util.Inl (_), _)::_, (FStar_Util.Inr (_), _)::_)) | (((FStar_Util.Inr (_), _)::_, (FStar_Util.Inl (_), _)::_)) -> begin
FStar_Util.Inr ("sort mismatch")
end
| (hd1::xs, hd2::ys) -> begin
(let subst = (let _152_1007 = (FStar_Absyn_Util.mk_subst_one_binder hd2 hd1)
in (FStar_List.append _152_1007 subst))
in (let env = (FStar_Tc_Env.push_local_binding env (FStar_Tc_Env.binding_of_binder hd2))
in (let prob = (match (((Prims.fst hd1), (Prims.fst hd2))) with
| (FStar_Util.Inl (a), FStar_Util.Inl (b)) -> begin
(let _152_1011 = (let _152_1010 = (FStar_Absyn_Util.subst_kind subst a.FStar_Absyn_Syntax.sort)
in (let _152_1009 = (FStar_All.pipe_left invert_rel (p_rel orig))
in (mk_problem ((hd2)::scope) orig _152_1010 _152_1009 b.FStar_Absyn_Syntax.sort None "Formal type parameter")))
in (FStar_All.pipe_left (fun _152_1008 -> KProb (_152_1008)) _152_1011))
end
| (FStar_Util.Inr (x), FStar_Util.Inr (y)) -> begin
(let _152_1015 = (let _152_1014 = (FStar_Absyn_Util.subst_typ subst x.FStar_Absyn_Syntax.sort)
in (let _152_1013 = (FStar_All.pipe_left invert_rel (p_rel orig))
in (mk_problem ((hd2)::scope) orig _152_1014 _152_1013 y.FStar_Absyn_Syntax.sort None "Formal value parameter")))
in (FStar_All.pipe_left (fun _152_1012 -> TProb (_152_1012)) _152_1015))
end
| _50_1983 -> begin
(FStar_All.failwith "impos")
end)
in (match ((aux ((hd2)::scope) env subst xs ys)) with
| FStar_Util.Inr (msg) -> begin
FStar_Util.Inr (msg)
end
| FStar_Util.Inl (sub_probs, phi) -> begin
(let phi = (let _152_1017 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (let _152_1016 = (FStar_Absyn_Util.close_forall ((hd2)::[]) phi)
in (FStar_Absyn_Util.mk_conj _152_1017 _152_1016)))
in FStar_Util.Inl (((prob)::sub_probs, phi)))
end))))
end
| _50_1993 -> begin
FStar_Util.Inr ("arity mismatch")
end))
in (let scope = (FStar_Tc_Env.binders env)
in (match ((aux scope env [] bs1 bs2)) with
| FStar_Util.Inr (msg) -> begin
(giveup env msg orig)
end
| FStar_Util.Inl (sub_probs, phi) -> begin
(let wl = (solve_prob orig (Some (phi)) [] wl)
in (solve env (attempt sub_probs wl)))
end))))
and solve_k : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.knd, Prims.unit) problem  ->  worklist  ->  solution = (fun env problem wl -> (match ((compress_prob wl (KProb (problem)))) with
| KProb (p) -> begin
(solve_k' env p wl)
end
| _50_2008 -> begin
(FStar_All.failwith "impossible")
end))
and solve_k' : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.knd, Prims.unit) problem  ->  worklist  ->  solution = (fun env problem wl -> (let orig = KProb (problem)
in if (FStar_Util.physical_equality problem.lhs problem.rhs) then begin
(let _152_1024 = (solve_prob orig None [] wl)
in (solve env _152_1024))
end else begin
(let k1 = problem.lhs
in (let k2 = problem.rhs
in if (FStar_Util.physical_equality k1 k2) then begin
(let _152_1025 = (solve_prob orig None [] wl)
in (solve env _152_1025))
end else begin
(let r = (FStar_Tc_Env.get_range env)
in (let imitate_k = (fun _50_2024 -> (match (_50_2024) with
| (rel, u, ps, xs, (h, qs)) -> begin
(let r = (FStar_Tc_Env.get_range env)
in (let _50_2029 = (imitation_sub_probs orig env xs ps qs)
in (match (_50_2029) with
| (sub_probs, gs_xs, f) -> begin
(let im = (let _152_1041 = (let _152_1040 = (h gs_xs)
in (xs, _152_1040))
in (FStar_Absyn_Syntax.mk_Kind_lam _152_1041 r))
in (let wl = (solve_prob orig (Some (f)) ((UK ((u, im)))::[]) wl)
in (solve env (attempt sub_probs wl))))
end)))
end))
in (let flex_rigid = (fun rel u args k -> (let maybe_vars1 = (pat_vars env [] args)
in (match (maybe_vars1) with
| Some (xs) -> begin
(let fvs1 = (FStar_Absyn_Syntax.freevars_of_binders xs)
in (let fvs2 = (FStar_Absyn_Util.freevars_kind k2)
in (let uvs2 = (FStar_Absyn_Util.uvars_in_kind k2)
in if (((FStar_Util.set_is_subset_of fvs2.FStar_Absyn_Syntax.ftvs fvs1.FStar_Absyn_Syntax.ftvs) && (FStar_Util.set_is_subset_of fvs2.FStar_Absyn_Syntax.fxvs fvs1.FStar_Absyn_Syntax.fxvs)) && (not ((FStar_Util.set_mem u uvs2.FStar_Absyn_Syntax.uvars_k)))) then begin
(let k1 = (FStar_Absyn_Syntax.mk_Kind_lam (xs, k2) r)
in (let _152_1050 = (solve_prob orig None ((UK ((u, k1)))::[]) wl)
in (solve env _152_1050)))
end else begin
(let _152_1055 = (let _152_1054 = (FStar_All.pipe_right xs FStar_Absyn_Util.args_of_non_null_binders)
in (let _152_1053 = (decompose_kind env k)
in (rel, u, _152_1054, xs, _152_1053)))
in (imitate_k _152_1055))
end)))
end
| None -> begin
(giveup env "flex-rigid: not a pattern" (KProb (problem)))
end)))
in (match ((k1.FStar_Absyn_Syntax.n, k2.FStar_Absyn_Syntax.n)) with
| ((FStar_Absyn_Syntax.Kind_type, FStar_Absyn_Syntax.Kind_type)) | ((FStar_Absyn_Syntax.Kind_effect, FStar_Absyn_Syntax.Kind_effect)) -> begin
(let _152_1056 = (solve_prob orig None [] wl)
in (FStar_All.pipe_left (solve env) _152_1056))
end
| (FStar_Absyn_Syntax.Kind_abbrev (_50_2052, k1), _50_2057) -> begin
(solve_k env (let _50_2059 = problem
in {lhs = k1; relation = _50_2059.relation; rhs = _50_2059.rhs; element = _50_2059.element; logical_guard = _50_2059.logical_guard; scope = _50_2059.scope; reason = _50_2059.reason; loc = _50_2059.loc; rank = _50_2059.rank}) wl)
end
| (_50_2062, FStar_Absyn_Syntax.Kind_abbrev (_50_2064, k2)) -> begin
(solve_k env (let _50_2069 = problem
in {lhs = _50_2069.lhs; relation = _50_2069.relation; rhs = k2; element = _50_2069.element; logical_guard = _50_2069.logical_guard; scope = _50_2069.scope; reason = _50_2069.reason; loc = _50_2069.loc; rank = _50_2069.rank}) wl)
end
| (FStar_Absyn_Syntax.Kind_arrow (bs1, k1'), FStar_Absyn_Syntax.Kind_arrow (bs2, k2')) -> begin
(let sub_prob = (fun scope env subst -> (let _152_1065 = (let _152_1064 = (FStar_Absyn_Util.subst_kind subst k1')
in (mk_problem scope orig _152_1064 problem.relation k2' None "Arrow-kind result"))
in (FStar_All.pipe_left (fun _152_1063 -> KProb (_152_1063)) _152_1065)))
in (solve_binders env bs1 bs2 orig wl sub_prob))
end
| (FStar_Absyn_Syntax.Kind_uvar (u1, args1), FStar_Absyn_Syntax.Kind_uvar (u2, args2)) -> begin
(let maybe_vars1 = (pat_vars env [] args1)
in (let maybe_vars2 = (pat_vars env [] args2)
in (match ((maybe_vars1, maybe_vars2)) with
| ((None, _)) | ((_, None)) -> begin
(giveup env "flex-flex: non patterns" (KProb (problem)))
end
| (Some (xs), Some (ys)) -> begin
if ((FStar_Unionfind.equivalent u1 u2) && (binders_eq xs ys)) then begin
(solve env wl)
end else begin
(let zs = (intersect_vars xs ys)
in (let _50_2112 = (new_kvar r zs)
in (match (_50_2112) with
| (u, _50_2111) -> begin
(let k1 = (FStar_Absyn_Syntax.mk_Kind_lam (xs, u) r)
in (let k2 = (FStar_Absyn_Syntax.mk_Kind_lam (ys, u) r)
in (let wl = (solve_prob orig None ((UK ((u1, k1)))::(UK ((u2, k2)))::[]) wl)
in (solve env wl))))
end)))
end
end)))
end
| (FStar_Absyn_Syntax.Kind_uvar (u, args), _50_2121) -> begin
(flex_rigid problem.relation u args k2)
end
| (_50_2124, FStar_Absyn_Syntax.Kind_uvar (u, args)) -> begin
(flex_rigid (invert_rel problem.relation) u args k1)
end
| ((FStar_Absyn_Syntax.Kind_delayed (_), _)) | ((FStar_Absyn_Syntax.Kind_unknown, _)) | ((_, FStar_Absyn_Syntax.Kind_delayed (_))) | ((_, FStar_Absyn_Syntax.Kind_unknown)) -> begin
(FStar_All.failwith "Impossible")
end
| _50_2151 -> begin
(giveup env "head mismatch (k-1)" (KProb (problem)))
end))))
end))
end))
and solve_t : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) problem  ->  worklist  ->  solution = (fun env problem wl -> (let p = (compress_prob wl (TProb (problem)))
in (match (p) with
| TProb (p) -> begin
(solve_t' env p wl)
end
| _50_2159 -> begin
(FStar_All.failwith "Impossible")
end)))
and solve_t' : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ, FStar_Absyn_Syntax.exp) problem  ->  worklist  ->  solution = (fun env problem wl -> (let giveup_or_defer = (fun orig msg -> if wl.defer_ok then begin
(let _50_2166 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1076 = (prob_to_string env orig)
in (FStar_Util.print2 "\n\t\tDeferring %s\n\t\tBecause %s\n" _152_1076 msg))
end else begin
()
end
in (solve env (defer msg orig wl)))
end else begin
(giveup env msg orig)
end)
in (let imitate_t = (fun orig env wl p -> (let _50_2183 = p
in (match (_50_2183) with
| ((u, k), ps, xs, (h, _50_2180, qs)) -> begin
(let xs = (sn_binders env xs)
in (let r = (FStar_Tc_Env.get_range env)
in (let _50_2189 = (imitation_sub_probs orig env xs ps qs)
in (match (_50_2189) with
| (sub_probs, gs_xs, formula) -> begin
(let im = (let _152_1088 = (let _152_1087 = (h gs_xs)
in (xs, _152_1087))
in (FStar_Absyn_Syntax.mk_Typ_lam' _152_1088 None r))
in (let _50_2191 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1093 = (FStar_Absyn_Print.typ_to_string im)
in (let _152_1092 = (FStar_Absyn_Print.tag_of_typ im)
in (let _152_1091 = (let _152_1089 = (FStar_List.map (prob_to_string env) sub_probs)
in (FStar_All.pipe_right _152_1089 (FStar_String.concat ", ")))
in (let _152_1090 = (FStar_Tc_Normalize.formula_norm_to_string env formula)
in (FStar_Util.print4 "Imitating %s (%s)\nsub_probs = %s\nformula=%s\n" _152_1093 _152_1092 _152_1091 _152_1090)))))
end else begin
()
end
in (let wl = (solve_prob orig (Some (formula)) ((UT (((u, k), im)))::[]) wl)
in (solve env (attempt sub_probs wl)))))
end))))
end)))
in (let project_t = (fun orig env wl i p -> (let _50_2207 = p
in (match (_50_2207) with
| (u, ps, xs, (h, matches, qs)) -> begin
(let r = (FStar_Tc_Env.get_range env)
in (let pi = (FStar_List.nth ps i)
in (let rec gs = (fun k -> (let _50_2214 = (FStar_Absyn_Util.kind_formals k)
in (match (_50_2214) with
| (bs, k) -> begin
(let rec aux = (fun subst bs -> (match (bs) with
| [] -> begin
([], [])
end
| hd::tl -> begin
(let _50_2243 = (match ((Prims.fst hd)) with
| FStar_Util.Inl (a) -> begin
(let k_a = (FStar_Absyn_Util.subst_kind subst a.FStar_Absyn_Syntax.sort)
in (let _50_2227 = (new_tvar r xs k_a)
in (match (_50_2227) with
| (gi_xs, gi) -> begin
(let gi_xs = (FStar_Tc_Normalize.eta_expand env gi_xs)
in (let gi_ps = (FStar_Absyn_Syntax.mk_Typ_app (gi, ps) (Some (k_a)) r)
in (let subst = if (FStar_Absyn_Syntax.is_null_binder hd) then begin
subst
end else begin
(FStar_Util.Inl ((a.FStar_Absyn_Syntax.v, gi_xs)))::subst
end
in ((FStar_Absyn_Syntax.targ gi_xs), (FStar_Absyn_Syntax.targ gi_ps), subst))))
end)))
end
| FStar_Util.Inr (x) -> begin
(let t_x = (FStar_Absyn_Util.subst_typ subst x.FStar_Absyn_Syntax.sort)
in (let _50_2236 = (new_evar r xs t_x)
in (match (_50_2236) with
| (gi_xs, gi) -> begin
(let gi_xs = (FStar_Tc_Normalize.eta_expand_exp env gi_xs)
in (let gi_ps = (FStar_Absyn_Syntax.mk_Exp_app (gi, ps) (Some (t_x)) r)
in (let subst = if (FStar_Absyn_Syntax.is_null_binder hd) then begin
subst
end else begin
(FStar_Util.Inr ((x.FStar_Absyn_Syntax.v, gi_xs)))::subst
end
in ((FStar_Absyn_Syntax.varg gi_xs), (FStar_Absyn_Syntax.varg gi_ps), subst))))
end)))
end)
in (match (_50_2243) with
| (gi_xs, gi_ps, subst) -> begin
(let _50_2246 = (aux subst tl)
in (match (_50_2246) with
| (gi_xs', gi_ps') -> begin
((gi_xs)::gi_xs', (gi_ps)::gi_ps')
end))
end))
end))
in (aux [] bs))
end)))
in (match ((let _152_1113 = (let _152_1112 = (FStar_List.nth xs i)
in (FStar_All.pipe_left Prims.fst _152_1112))
in ((Prims.fst pi), _152_1113))) with
| (FStar_Util.Inl (pi), FStar_Util.Inl (xi)) -> begin
if (let _152_1114 = (matches pi)
in (FStar_All.pipe_left Prims.op_Negation _152_1114)) then begin
None
end else begin
(let _50_2255 = (gs xi.FStar_Absyn_Syntax.sort)
in (match (_50_2255) with
| (g_xs, _50_2254) -> begin
(let xi = (FStar_Absyn_Util.btvar_to_typ xi)
in (let proj = (let _152_1116 = (let _152_1115 = (FStar_Absyn_Syntax.mk_Typ_app' (xi, g_xs) (Some (FStar_Absyn_Syntax.ktype)) r)
in (xs, _152_1115))
in (FStar_Absyn_Syntax.mk_Typ_lam _152_1116 None r))
in (let sub = (let _152_1122 = (let _152_1121 = (FStar_Absyn_Syntax.mk_Typ_app' (proj, ps) (Some (FStar_Absyn_Syntax.ktype)) r)
in (let _152_1120 = (let _152_1119 = (FStar_List.map (fun _50_2263 -> (match (_50_2263) with
| (_50_2259, _50_2261, y) -> begin
y
end)) qs)
in (FStar_All.pipe_left h _152_1119))
in (mk_problem (p_scope orig) orig _152_1121 (p_rel orig) _152_1120 None "projection")))
in (FStar_All.pipe_left (fun _152_1117 -> TProb (_152_1117)) _152_1122))
in (let _50_2265 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1124 = (FStar_Absyn_Print.typ_to_string proj)
in (let _152_1123 = (prob_to_string env sub)
in (FStar_Util.print2 "Projecting %s\n\tsubprob=%s\n" _152_1124 _152_1123)))
end else begin
()
end
in (let wl = (let _152_1126 = (let _152_1125 = (FStar_All.pipe_left Prims.fst (p_guard sub))
in Some (_152_1125))
in (solve_prob orig _152_1126 ((UT ((u, proj)))::[]) wl))
in (let _152_1128 = (solve env (attempt ((sub)::[]) wl))
in (FStar_All.pipe_left (fun _152_1127 -> Some (_152_1127)) _152_1128)))))))
end))
end
end
| _50_2269 -> begin
None
end))))
end)))
in (let solve_t_flex_rigid = (fun orig lhs t2 wl -> (let _50_2281 = lhs
in (match (_50_2281) with
| ((t1, uv, k, args_lhs), maybe_pat_vars) -> begin
(let subterms = (fun ps -> (let xs = (let _152_1155 = (FStar_Absyn_Util.kind_formals k)
in (FStar_All.pipe_right _152_1155 Prims.fst))
in (let xs = (FStar_Absyn_Util.name_binders xs)
in (let _152_1160 = (decompose_typ env t2)
in ((uv, k), ps, xs, _152_1160)))))
in (let rec imitate_or_project = (fun n st i -> if (i >= n) then begin
(giveup env "flex-rigid case failed all backtracking attempts" orig)
end else begin
if (i = (- (1))) then begin
(match ((imitate_t orig env wl st)) with
| Failed (_50_2291) -> begin
(imitate_or_project n st (i + 1))
end
| sol -> begin
sol
end)
end else begin
(match ((project_t orig env wl i st)) with
| (None) | (Some (Failed (_))) -> begin
(imitate_or_project n st (i + 1))
end
| Some (sol) -> begin
sol
end)
end
end)
in (let check_head = (fun fvs1 t2 -> (let _50_2307 = (FStar_Absyn_Util.head_and_args t2)
in (match (_50_2307) with
| (hd, _50_2306) -> begin
(match (hd.FStar_Absyn_Syntax.n) with
| (FStar_Absyn_Syntax.Typ_fun (_)) | (FStar_Absyn_Syntax.Typ_const (_)) | (FStar_Absyn_Syntax.Typ_lam (_)) -> begin
true
end
| _50_2318 -> begin
(let fvs_hd = (FStar_Absyn_Util.freevars_typ hd)
in if (FStar_Absyn_Util.fvs_included fvs_hd fvs1) then begin
true
end else begin
(let _50_2320 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1171 = (FStar_Absyn_Print.freevars_to_string fvs_hd)
in (FStar_Util.print1 "Free variables are %s" _152_1171))
end else begin
()
end
in false)
end)
end)
end)))
in (let imitate_ok = (fun t2 -> (let fvs_hd = (let _152_1175 = (let _152_1174 = (FStar_Absyn_Util.head_and_args t2)
in (FStar_All.pipe_right _152_1174 Prims.fst))
in (FStar_All.pipe_right _152_1175 FStar_Absyn_Util.freevars_typ))
in if (FStar_Util.set_is_empty fvs_hd.FStar_Absyn_Syntax.ftvs) then begin
(- (1))
end else begin
0
end))
in (match (maybe_pat_vars) with
| Some (vars) -> begin
(let t1 = (sn env t1)
in (let t2 = (sn env t2)
in (let fvs1 = (FStar_Absyn_Util.freevars_typ t1)
in (let fvs2 = (FStar_Absyn_Util.freevars_typ t2)
in (let _50_2333 = (occurs_check env wl (uv, k) t2)
in (match (_50_2333) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(let _152_1177 = (let _152_1176 = (FStar_Option.get msg)
in (Prims.strcat "occurs-check failed: " _152_1176))
in (giveup_or_defer orig _152_1177))
end else begin
if (FStar_Absyn_Util.fvs_included fvs2 fvs1) then begin
if ((FStar_Absyn_Util.is_function_typ t2) && ((p_rel orig) <> EQ)) then begin
(let _152_1178 = (subterms args_lhs)
in (imitate_t orig env wl _152_1178))
end else begin
(let _50_2334 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1181 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1180 = (FStar_Absyn_Print.freevars_to_string fvs1)
in (let _152_1179 = (FStar_Absyn_Print.freevars_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s succeeded fvar check: %s\n" _152_1181 _152_1180 _152_1179))))
end else begin
()
end
in (let sol = (match (vars) with
| [] -> begin
t2
end
| _50_2338 -> begin
(let _152_1183 = (let _152_1182 = (sn_binders env vars)
in (_152_1182, t2))
in (FStar_Absyn_Syntax.mk_Typ_lam _152_1183 None t1.FStar_Absyn_Syntax.pos))
end)
in (let wl = (solve_prob orig None ((UT (((uv, k), sol)))::[]) wl)
in (solve env wl))))
end
end else begin
if wl.defer_ok then begin
(solve env (defer "flex pattern/rigid: occurs or freevar check" orig wl))
end else begin
if (check_head fvs1 t2) then begin
(let _50_2341 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1186 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1185 = (FStar_Absyn_Print.freevars_to_string fvs1)
in (let _152_1184 = (FStar_Absyn_Print.freevars_to_string fvs2)
in (FStar_Util.print3 "Pattern %s with fvars=%s failed fvar check: %s ... imitating\n" _152_1186 _152_1185 _152_1184))))
end else begin
()
end
in (let _152_1187 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _152_1187 (- (1)))))
end else begin
(giveup env "free-variable check failed on a non-redex" orig)
end
end
end
end
end))))))
end
| None -> begin
if wl.defer_ok then begin
(solve env (defer "not a pattern" orig wl))
end else begin
if (let _152_1188 = (FStar_Absyn_Util.freevars_typ t1)
in (check_head _152_1188 t2)) then begin
(let im_ok = (imitate_ok t2)
in (let _50_2345 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1189 = (FStar_Absyn_Print.typ_to_string t1)
in (FStar_Util.print2 "Not a pattern (%s) ... %s\n" _152_1189 (if (im_ok < 0) then begin
"imitating"
end else begin
"projecting"
end)))
end else begin
()
end
in (let _152_1190 = (subterms args_lhs)
in (imitate_or_project (FStar_List.length args_lhs) _152_1190 im_ok))))
end else begin
(giveup env "head-symbol is free" orig)
end
end
end)))))
end)))
in (let flex_flex = (fun orig lhs rhs -> if (wl.defer_ok && ((p_rel orig) <> EQ)) then begin
(solve env (defer "flex-flex deferred" orig wl))
end else begin
(let force_quasi_pattern = (fun xs_opt _50_2357 -> (match (_50_2357) with
| (t, u, k, args) -> begin
(let rec aux = (fun binders ys args -> (match (args) with
| [] -> begin
(let ys = (FStar_List.rev ys)
in (let binders = (FStar_List.rev binders)
in (let kk = (FStar_Tc_Recheck.recompute_kind t)
in (let _50_2369 = (new_tvar t.FStar_Absyn_Syntax.pos ys kk)
in (match (_50_2369) with
| (t', _50_2368) -> begin
(let _50_2375 = (destruct_flex_t t')
in (match (_50_2375) with
| (u1_ys, u1, k1, _50_2374) -> begin
(let sol = (let _152_1208 = (let _152_1207 = (FStar_Absyn_Syntax.mk_Typ_lam (binders, u1_ys) (Some (k)) t.FStar_Absyn_Syntax.pos)
in ((u, k), _152_1207))
in UT (_152_1208))
in (sol, (t', u, k1, ys)))
end))
end)))))
end
| hd::tl -> begin
(let new_binder = (fun hd -> (match ((Prims.fst hd)) with
| FStar_Util.Inl (a) -> begin
(let _152_1212 = (let _152_1211 = (FStar_Tc_Recheck.recompute_kind a)
in (FStar_All.pipe_right _152_1211 (FStar_Absyn_Util.gen_bvar_p a.FStar_Absyn_Syntax.pos)))
in (FStar_All.pipe_right _152_1212 FStar_Absyn_Syntax.t_binder))
end
| FStar_Util.Inr (x) -> begin
(let _152_1214 = (let _152_1213 = (FStar_Tc_Recheck.recompute_typ x)
in (FStar_All.pipe_right _152_1213 (FStar_Absyn_Util.gen_bvar_p x.FStar_Absyn_Syntax.pos)))
in (FStar_All.pipe_right _152_1214 FStar_Absyn_Syntax.v_binder))
end))
in (let _50_2394 = (match ((pat_var_opt env ys hd)) with
| None -> begin
(let _152_1215 = (new_binder hd)
in (_152_1215, ys))
end
| Some (y) -> begin
(match (xs_opt) with
| None -> begin
(y, (y)::ys)
end
| Some (xs) -> begin
if (FStar_All.pipe_right xs (FStar_Util.for_some (FStar_Absyn_Util.eq_binder y))) then begin
(y, (y)::ys)
end else begin
(let _152_1216 = (new_binder hd)
in (_152_1216, ys))
end
end)
end)
in (match (_50_2394) with
| (binder, ys) -> begin
(aux ((binder)::binders) ys tl)
end)))
end))
in (aux [] [] args))
end))
in (let solve_both_pats = (fun wl _50_2400 _50_2404 k r -> (match ((_50_2400, _50_2404)) with
| ((u1, k1, xs), (u2, k2, ys)) -> begin
if ((FStar_Unionfind.equivalent u1 u2) && (binders_eq xs ys)) then begin
(let _152_1227 = (solve_prob orig None [] wl)
in (solve env _152_1227))
end else begin
(let xs = (sn_binders env xs)
in (let ys = (sn_binders env ys)
in (let zs = (intersect_vars xs ys)
in (let _50_2413 = (new_tvar r zs k)
in (match (_50_2413) with
| (u_zs, _50_2412) -> begin
(let sub1 = (FStar_Absyn_Syntax.mk_Typ_lam' (xs, u_zs) (Some (k1)) r)
in (let _50_2417 = (occurs_check env wl (u1, k1) sub1)
in (match (_50_2417) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occcurs check")
end else begin
(let sol1 = UT (((u1, k1), sub1))
in if (FStar_Unionfind.equivalent u1 u2) then begin
(let wl = (solve_prob orig None ((sol1)::[]) wl)
in (solve env wl))
end else begin
(let sub2 = (FStar_Absyn_Syntax.mk_Typ_lam' (ys, u_zs) (Some (k2)) r)
in (let _50_2423 = (occurs_check env wl (u2, k2) sub2)
in (match (_50_2423) with
| (occurs_ok, msg) -> begin
if (not (occurs_ok)) then begin
(giveup_or_defer orig "flex-flex: failed occurs check")
end else begin
(let sol2 = UT (((u2, k2), sub2))
in (let wl = (solve_prob orig None ((sol1)::(sol2)::[]) wl)
in (solve env wl)))
end
end)))
end)
end
end)))
end)))))
end
end))
in (let solve_one_pat = (fun _50_2431 _50_2436 -> (match ((_50_2431, _50_2436)) with
| ((t1, u1, k1, xs), (t2, u2, k2, args2)) -> begin
(let _50_2437 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1233 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1232 = (FStar_Absyn_Print.typ_to_string t2)
in (FStar_Util.print2 "Trying flex-flex one pattern (%s) with %s\n" _152_1233 _152_1232)))
end else begin
()
end
in if (FStar_Unionfind.equivalent u1 u2) then begin
(let sub_probs = (FStar_List.map2 (fun a b -> (let a = (FStar_Absyn_Util.arg_of_non_null_binder a)
in (match (((Prims.fst a), (Prims.fst b))) with
| (FStar_Util.Inl (t1), FStar_Util.Inl (t2)) -> begin
(let _152_1237 = (mk_problem (p_scope orig) orig t1 EQ t2 None "flex-flex index")
in (FStar_All.pipe_right _152_1237 (fun _152_1236 -> TProb (_152_1236))))
end
| (FStar_Util.Inr (t1), FStar_Util.Inr (t2)) -> begin
(let _152_1239 = (mk_problem (p_scope orig) orig t1 EQ t2 None "flex-flex index")
in (FStar_All.pipe_right _152_1239 (fun _152_1238 -> EProb (_152_1238))))
end
| _50_2453 -> begin
(FStar_All.failwith "Impossible")
end))) xs args2)
in (let guard = (let _152_1241 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Absyn_Util.mk_conj_l _152_1241))
in (let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))
end else begin
(let t2 = (sn env t2)
in (let rhs_vars = (FStar_Absyn_Util.freevars_typ t2)
in (let _50_2463 = (occurs_check env wl (u1, k1) t2)
in (match (_50_2463) with
| (occurs_ok, _50_2462) -> begin
(let lhs_vars = (FStar_Absyn_Syntax.freevars_of_binders xs)
in if (occurs_ok && (FStar_Absyn_Util.fvs_included rhs_vars lhs_vars)) then begin
(let sol = (let _152_1243 = (let _152_1242 = (FStar_Absyn_Syntax.mk_Typ_lam' (xs, t2) (Some (k1)) t1.FStar_Absyn_Syntax.pos)
in ((u1, k1), _152_1242))
in UT (_152_1243))
in (let wl = (solve_prob orig None ((sol)::[]) wl)
in (solve env wl)))
end else begin
if (occurs_ok && (FStar_All.pipe_left Prims.op_Negation wl.defer_ok)) then begin
(let _50_2474 = (force_quasi_pattern (Some (xs)) (t2, u2, k2, args2))
in (match (_50_2474) with
| (sol, (_50_2469, u2, k2, ys)) -> begin
(let wl = (extend_solution sol wl)
in (let _50_2476 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _152_1244 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (2): %s\n" _152_1244))
end else begin
()
end
in (match (orig) with
| TProb (p) -> begin
(solve_t env p wl)
end
| _50_2481 -> begin
(giveup env "impossible" orig)
end)))
end))
end else begin
(giveup_or_defer orig "flex-flex constraint")
end
end)
end))))
end)
end))
in (let _50_2486 = lhs
in (match (_50_2486) with
| (t1, u1, k1, args1) -> begin
(let _50_2491 = rhs
in (match (_50_2491) with
| (t2, u2, k2, args2) -> begin
(let maybe_pat_vars1 = (pat_vars env [] args1)
in (let maybe_pat_vars2 = (pat_vars env [] args2)
in (let r = t2.FStar_Absyn_Syntax.pos
in (match ((maybe_pat_vars1, maybe_pat_vars2)) with
| (Some (xs), Some (ys)) -> begin
(let _152_1245 = (FStar_Tc_Recheck.recompute_kind t2)
in (solve_both_pats wl (u1, k1, xs) (u2, k2, ys) _152_1245 t2.FStar_Absyn_Syntax.pos))
end
| (Some (xs), None) -> begin
(solve_one_pat (t1, u1, k1, xs) rhs)
end
| (None, Some (ys)) -> begin
(solve_one_pat (t2, u2, k2, ys) lhs)
end
| _50_2509 -> begin
if wl.defer_ok then begin
(giveup_or_defer orig "flex-flex: neither side is a pattern")
end else begin
(let _50_2513 = (force_quasi_pattern None (t1, u1, k1, args1))
in (match (_50_2513) with
| (sol, _50_2512) -> begin
(let wl = (extend_solution sol wl)
in (let _50_2515 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("QuasiPattern"))) then begin
(let _152_1246 = (uvi_to_string env sol)
in (FStar_Util.print1 "flex-flex quasi pattern (1): %s\n" _152_1246))
end else begin
()
end
in (match (orig) with
| TProb (p) -> begin
(solve_t env p wl)
end
| _50_2520 -> begin
(giveup env "impossible" orig)
end)))
end))
end
end))))
end))
end)))))
end)
in (let orig = TProb (problem)
in if (FStar_Util.physical_equality problem.lhs problem.rhs) then begin
(let _152_1247 = (solve_prob orig None [] wl)
in (solve env _152_1247))
end else begin
(let t1 = problem.lhs
in (let t2 = problem.rhs
in if (FStar_Util.physical_equality t1 t2) then begin
(let _152_1248 = (solve_prob orig None [] wl)
in (solve env _152_1248))
end else begin
(let _50_2524 = if (FStar_Tc_Env.debug env (FStar_Options.Other ("Rel"))) then begin
(let _152_1251 = (prob_to_string env orig)
in (let _152_1250 = (let _152_1249 = (FStar_List.map (uvi_to_string wl.tcenv) wl.subst)
in (FStar_All.pipe_right _152_1249 (FStar_String.concat "; ")))
in (FStar_Util.print2 "Attempting %s\n\tSubst is %s\n" _152_1251 _152_1250)))
end else begin
()
end
in (let r = (FStar_Tc_Env.get_range env)
in (let match_num_binders = (fun _50_2529 _50_2532 -> (match ((_50_2529, _50_2532)) with
| ((bs1, mk_cod1), (bs2, mk_cod2)) -> begin
(let curry = (fun n bs mk_cod -> (let _50_2539 = (FStar_Util.first_N n bs)
in (match (_50_2539) with
| (bs, rest) -> begin
(let _152_1281 = (mk_cod rest)
in (bs, _152_1281))
end)))
in (let l1 = (FStar_List.length bs1)
in (let l2 = (FStar_List.length bs2)
in if (l1 = l2) then begin
(let _152_1285 = (let _152_1282 = (mk_cod1 [])
in (bs1, _152_1282))
in (let _152_1284 = (let _152_1283 = (mk_cod2 [])
in (bs2, _152_1283))
in (_152_1285, _152_1284)))
end else begin
if (l1 > l2) then begin
(let _152_1288 = (curry l2 bs1 mk_cod1)
in (let _152_1287 = (let _152_1286 = (mk_cod2 [])
in (bs2, _152_1286))
in (_152_1288, _152_1287)))
end else begin
(let _152_1291 = (let _152_1289 = (mk_cod1 [])
in (bs1, _152_1289))
in (let _152_1290 = (curry l1 bs2 mk_cod2)
in (_152_1291, _152_1290)))
end
end)))
end))
in (match ((t1.FStar_Absyn_Syntax.n, t2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Typ_btvar (a), FStar_Absyn_Syntax.Typ_btvar (b)) -> begin
if (FStar_Absyn_Util.bvd_eq a.FStar_Absyn_Syntax.v b.FStar_Absyn_Syntax.v) then begin
(let _152_1292 = (solve_prob orig None [] wl)
in (solve env _152_1292))
end else begin
(let _152_1296 = (let _152_1295 = (let _152_1294 = (FStar_Absyn_Util.mk_eq_typ t1 t2)
in (FStar_All.pipe_left (fun _152_1293 -> Some (_152_1293)) _152_1294))
in (solve_prob orig _152_1295 [] wl))
in (solve env _152_1296))
end
end
| (FStar_Absyn_Syntax.Typ_fun (bs1, c1), FStar_Absyn_Syntax.Typ_fun (bs2, c2)) -> begin
(let mk_c = (fun c _50_31 -> (match (_50_31) with
| [] -> begin
c
end
| bs -> begin
(let _152_1301 = (FStar_Absyn_Syntax.mk_Typ_fun (bs, c) None c.FStar_Absyn_Syntax.pos)
in (FStar_Absyn_Syntax.mk_Total _152_1301))
end))
in (let _50_2570 = (match_num_binders (bs1, (mk_c c1)) (bs2, (mk_c c2)))
in (match (_50_2570) with
| ((bs1, c1), (bs2, c2)) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (let c1 = (FStar_Absyn_Util.subst_comp subst c1)
in (let rel = if (FStar_ST.read FStar_Options.use_eq_at_higher_order) then begin
EQ
end else begin
problem.relation
end
in (let _50_2576 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("EQ"))) then begin
(let _152_1307 = (FStar_All.pipe_right (FStar_Tc_Env.get_range env) FStar_Range.string_of_range)
in (FStar_Util.print2 "(%s) Using relation %s at higher order\n" _152_1307 (rel_to_string rel)))
end else begin
()
end
in (let _152_1309 = (mk_problem scope orig c1 rel c2 None "function co-domain")
in (FStar_All.pipe_left (fun _152_1308 -> CProb (_152_1308)) _152_1309)))))))
end)))
end
| (FStar_Absyn_Syntax.Typ_lam (bs1, t1'), FStar_Absyn_Syntax.Typ_lam (bs2, t2')) -> begin
(let mk_t = (fun t _50_32 -> (match (_50_32) with
| [] -> begin
t
end
| bs -> begin
(FStar_Absyn_Syntax.mk_Typ_lam (bs, t) None t.FStar_Absyn_Syntax.pos)
end))
in (let _50_2598 = (match_num_binders (bs1, (mk_t t1')) (bs2, (mk_t t2')))
in (match (_50_2598) with
| ((bs1, t1'), (bs2, t2')) -> begin
(solve_binders env bs1 bs2 orig wl (fun scope env subst -> (let t1' = (FStar_Absyn_Util.subst_typ subst t1')
in (let _152_1320 = (mk_problem scope orig t1' problem.relation t2' None "lambda co-domain")
in (FStar_All.pipe_left (fun _152_1319 -> TProb (_152_1319)) _152_1320)))))
end)))
end
| (FStar_Absyn_Syntax.Typ_refine (_50_2604), FStar_Absyn_Syntax.Typ_refine (_50_2607)) -> begin
(let _50_2612 = (as_refinement env wl t1)
in (match (_50_2612) with
| (x1, phi1) -> begin
(let _50_2615 = (as_refinement env wl t2)
in (match (_50_2615) with
| (x2, phi2) -> begin
(let base_prob = (let _152_1322 = (mk_problem (p_scope orig) orig x1.FStar_Absyn_Syntax.sort problem.relation x2.FStar_Absyn_Syntax.sort problem.element "refinement base type")
in (FStar_All.pipe_left (fun _152_1321 -> TProb (_152_1321)) _152_1322))
in (let x1_for_x2 = (FStar_Absyn_Util.mk_subst_one_binder (FStar_Absyn_Syntax.v_binder x1) (FStar_Absyn_Syntax.v_binder x2))
in (let phi2 = (FStar_Absyn_Util.subst_typ x1_for_x2 phi2)
in (let mk_imp = (fun imp phi1 phi2 -> (let _152_1339 = (imp phi1 phi2)
in (FStar_All.pipe_right _152_1339 (guard_on_element problem x1))))
in (let fallback = (fun _50_2624 -> (match (()) with
| () -> begin
(let impl = if (problem.relation = EQ) then begin
(mk_imp FStar_Absyn_Util.mk_iff phi1 phi2)
end else begin
(mk_imp FStar_Absyn_Util.mk_imp phi1 phi2)
end
in (let guard = (let _152_1342 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Absyn_Util.mk_conj _152_1342 impl))
in (let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
in if (problem.relation = EQ) then begin
(let ref_prob = (let _152_1344 = (mk_problem (p_scope orig) orig phi1 EQ phi2 None "refinement formula")
in (FStar_All.pipe_left (fun _152_1343 -> TProb (_152_1343)) _152_1344))
in (match ((solve env (let _50_2629 = wl
in {attempting = (ref_prob)::[]; wl_deferred = []; subst = _50_2629.subst; ctr = _50_2629.ctr; slack_vars = _50_2629.slack_vars; defer_ok = false; smt_ok = _50_2629.smt_ok; tcenv = _50_2629.tcenv}))) with
| Failed (_50_2632) -> begin
(fallback ())
end
| Success (subst, _50_2636) -> begin
(let guard = (let _152_1347 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (let _152_1346 = (let _152_1345 = (FStar_All.pipe_right (p_guard ref_prob) Prims.fst)
in (FStar_All.pipe_right _152_1345 (guard_on_element problem x1)))
in (FStar_Absyn_Util.mk_conj _152_1347 _152_1346)))
in (let wl = (solve_prob orig (Some (guard)) [] wl)
in (let wl = (let _50_2641 = wl
in {attempting = _50_2641.attempting; wl_deferred = _50_2641.wl_deferred; subst = subst; ctr = (wl.ctr + 1); slack_vars = _50_2641.slack_vars; defer_ok = _50_2641.defer_ok; smt_ok = _50_2641.smt_ok; tcenv = _50_2641.tcenv})
in (solve env (attempt ((base_prob)::[]) wl)))))
end))
end else begin
(fallback ())
end)))))
end))
end))
end
| ((FStar_Absyn_Syntax.Typ_uvar (_), FStar_Absyn_Syntax.Typ_uvar (_))) | ((FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), FStar_Absyn_Syntax.Typ_uvar (_))) | ((FStar_Absyn_Syntax.Typ_uvar (_), FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) | ((FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) -> begin
(let _152_1349 = (destruct_flex_t t1)
in (let _152_1348 = (destruct_flex_t t2)
in (flex_flex orig _152_1349 _152_1348)))
end
| ((FStar_Absyn_Syntax.Typ_uvar (_), _)) | ((FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), _)) when (problem.relation = EQ) -> begin
(let _152_1350 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid orig _152_1350 t2 wl))
end
| ((_, FStar_Absyn_Syntax.Typ_uvar (_))) | ((_, FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) when (problem.relation = EQ) -> begin
(solve_t env (invert problem) wl)
end
| ((FStar_Absyn_Syntax.Typ_uvar (_), _)) | ((FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), _)) -> begin
if wl.defer_ok then begin
(solve env (defer "flex-rigid subtyping deferred" orig wl))
end else begin
(let new_rel = if (FStar_ST.read FStar_Options.no_slack) then begin
EQ
end else begin
problem.relation
end
in if (let _152_1351 = (is_top_level_prob orig)
in (FStar_All.pipe_left Prims.op_Negation _152_1351)) then begin
(let _152_1354 = (FStar_All.pipe_left (fun _152_1352 -> TProb (_152_1352)) (let _50_2800 = problem
in {lhs = _50_2800.lhs; relation = new_rel; rhs = _50_2800.rhs; element = _50_2800.element; logical_guard = _50_2800.logical_guard; scope = _50_2800.scope; reason = _50_2800.reason; loc = _50_2800.loc; rank = _50_2800.rank}))
in (let _152_1353 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _152_1354 _152_1353 t2 wl)))
end else begin
(let _50_2804 = (base_and_refinement env wl t2)
in (match (_50_2804) with
| (t_base, ref_opt) -> begin
(match (ref_opt) with
| None -> begin
(let _152_1357 = (FStar_All.pipe_left (fun _152_1355 -> TProb (_152_1355)) (let _50_2806 = problem
in {lhs = _50_2806.lhs; relation = new_rel; rhs = _50_2806.rhs; element = _50_2806.element; logical_guard = _50_2806.logical_guard; scope = _50_2806.scope; reason = _50_2806.reason; loc = _50_2806.loc; rank = _50_2806.rank}))
in (let _152_1356 = (destruct_flex_pattern env t1)
in (solve_t_flex_rigid _152_1357 _152_1356 t_base wl)))
end
| Some (y, phi) -> begin
(let y' = (let _50_2812 = y
in {FStar_Absyn_Syntax.v = _50_2812.FStar_Absyn_Syntax.v; FStar_Absyn_Syntax.sort = t1; FStar_Absyn_Syntax.p = _50_2812.FStar_Absyn_Syntax.p})
in (let impl = (guard_on_element problem y' phi)
in (let base_prob = (let _152_1359 = (mk_problem problem.scope orig t1 new_rel y.FStar_Absyn_Syntax.sort problem.element "flex-rigid: base type")
in (FStar_All.pipe_left (fun _152_1358 -> TProb (_152_1358)) _152_1359))
in (let guard = (let _152_1360 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Absyn_Util.mk_conj _152_1360 impl))
in (let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt ((base_prob)::[]) wl)))))))
end)
end))
end)
end
end
| ((_, FStar_Absyn_Syntax.Typ_uvar (_))) | ((_, FStar_Absyn_Syntax.Typ_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Typ_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) -> begin
if wl.defer_ok then begin
(solve env (defer "rigid-flex subtyping deferred" orig wl))
end else begin
(let _50_2847 = (base_and_refinement env wl t1)
in (match (_50_2847) with
| (t_base, _50_2846) -> begin
(solve_t env (let _50_2848 = problem
in {lhs = t_base; relation = EQ; rhs = _50_2848.rhs; element = _50_2848.element; logical_guard = _50_2848.logical_guard; scope = _50_2848.scope; reason = _50_2848.reason; loc = _50_2848.loc; rank = _50_2848.rank}) wl)
end))
end
end
| (FStar_Absyn_Syntax.Typ_refine (_50_2851), _50_2854) -> begin
(let t2 = (let _152_1361 = (base_and_refinement env wl t2)
in (FStar_All.pipe_left force_refinement _152_1361))
in (solve_t env (let _50_2857 = problem
in {lhs = _50_2857.lhs; relation = _50_2857.relation; rhs = t2; element = _50_2857.element; logical_guard = _50_2857.logical_guard; scope = _50_2857.scope; reason = _50_2857.reason; loc = _50_2857.loc; rank = _50_2857.rank}) wl))
end
| (_50_2860, FStar_Absyn_Syntax.Typ_refine (_50_2862)) -> begin
(let t1 = (let _152_1362 = (base_and_refinement env wl t1)
in (FStar_All.pipe_left force_refinement _152_1362))
in (solve_t env (let _50_2866 = problem
in {lhs = t1; relation = _50_2866.relation; rhs = _50_2866.rhs; element = _50_2866.element; logical_guard = _50_2866.logical_guard; scope = _50_2866.scope; reason = _50_2866.reason; loc = _50_2866.loc; rank = _50_2866.rank}) wl))
end
| ((FStar_Absyn_Syntax.Typ_btvar (_), _)) | ((FStar_Absyn_Syntax.Typ_const (_), _)) | ((FStar_Absyn_Syntax.Typ_app (_), _)) | ((_, FStar_Absyn_Syntax.Typ_btvar (_))) | ((_, FStar_Absyn_Syntax.Typ_const (_))) | ((_, FStar_Absyn_Syntax.Typ_app (_))) -> begin
(let _50_2906 = (head_matches_delta env wl t1 t2)
in (match (_50_2906) with
| (m, o) -> begin
(match ((m, o)) with
| (MisMatch, _50_2909) -> begin
(let head1 = (let _152_1363 = (FStar_Absyn_Util.head_and_args t1)
in (FStar_All.pipe_right _152_1363 Prims.fst))
in (let head2 = (let _152_1364 = (FStar_Absyn_Util.head_and_args t2)
in (FStar_All.pipe_right _152_1364 Prims.fst))
in (let may_equate = (fun head -> (match (head.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_btvar (_50_2916) -> begin
true
end
| FStar_Absyn_Syntax.Typ_const (tc) -> begin
(FStar_Tc_Env.is_projector env tc.FStar_Absyn_Syntax.v)
end
| _50_2921 -> begin
false
end))
in if (((may_equate head1) || (may_equate head2)) && wl.smt_ok) then begin
(let _152_1370 = (let _152_1369 = (let _152_1368 = (FStar_Absyn_Util.mk_eq_typ t1 t2)
in (FStar_All.pipe_left (fun _152_1367 -> Some (_152_1367)) _152_1368))
in (solve_prob orig _152_1369 [] wl))
in (solve env _152_1370))
end else begin
(giveup env "head mismatch" orig)
end)))
end
| (_50_2923, Some (t1, t2)) -> begin
(solve_t env (let _50_2929 = problem
in {lhs = t1; relation = _50_2929.relation; rhs = t2; element = _50_2929.element; logical_guard = _50_2929.logical_guard; scope = _50_2929.scope; reason = _50_2929.reason; loc = _50_2929.loc; rank = _50_2929.rank}) wl)
end
| (_50_2932, None) -> begin
(let _50_2935 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1372 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1371 = (FStar_Absyn_Print.typ_to_string t2)
in (FStar_Util.print2 "Head matches: %s and %s\n" _152_1372 _152_1371)))
end else begin
()
end
in (let _50_2939 = (FStar_Absyn_Util.head_and_args t1)
in (match (_50_2939) with
| (head, args) -> begin
(let _50_2942 = (FStar_Absyn_Util.head_and_args t2)
in (match (_50_2942) with
| (head', args') -> begin
(let nargs = (FStar_List.length args)
in if (nargs <> (FStar_List.length args')) then begin
(let _152_1377 = (let _152_1376 = (FStar_Absyn_Print.typ_to_string head)
in (let _152_1375 = (FStar_Absyn_Print.args_to_string args)
in (let _152_1374 = (FStar_Absyn_Print.typ_to_string head')
in (let _152_1373 = (FStar_Absyn_Print.args_to_string args')
in (FStar_Util.format4 "unequal number of arguments: %s[%s] and %s[%s]" _152_1376 _152_1375 _152_1374 _152_1373)))))
in (giveup env _152_1377 orig))
end else begin
if ((nargs = 0) || (eq_args args args')) then begin
(let _152_1378 = (solve_prob orig None [] wl)
in (solve env _152_1378))
end else begin
(let _50_2946 = (base_and_refinement env wl t1)
in (match (_50_2946) with
| (base1, refinement1) -> begin
(let _50_2949 = (base_and_refinement env wl t2)
in (match (_50_2949) with
| (base2, refinement2) -> begin
(match ((refinement1, refinement2)) with
| (None, None) -> begin
(let _50_2953 = if ((head_matches head head) <> FullMatch) then begin
(let _152_1381 = (let _152_1380 = (FStar_Absyn_Print.typ_to_string head)
in (let _152_1379 = (FStar_Absyn_Print.typ_to_string head')
in (FStar_Util.format2 "Assertion failed: expected full match of %s and %s\n" _152_1380 _152_1379)))
in (FStar_All.failwith _152_1381))
end else begin
()
end
in (let subprobs = (FStar_List.map2 (fun a a' -> (match (((Prims.fst a), (Prims.fst a'))) with
| (FStar_Util.Inl (t), FStar_Util.Inl (t')) -> begin
(let _152_1385 = (mk_problem (p_scope orig) orig t EQ t' None "type index")
in (FStar_All.pipe_left (fun _152_1384 -> TProb (_152_1384)) _152_1385))
end
| (FStar_Util.Inr (v), FStar_Util.Inr (v')) -> begin
(let _152_1387 = (mk_problem (p_scope orig) orig v EQ v' None "term index")
in (FStar_All.pipe_left (fun _152_1386 -> EProb (_152_1386)) _152_1387))
end
| _50_2968 -> begin
(FStar_All.failwith "Impossible")
end)) args args')
in (let formula = (let _152_1389 = (FStar_List.map (fun p -> (Prims.fst (p_guard p))) subprobs)
in (FStar_Absyn_Util.mk_conj_l _152_1389))
in (let wl = (solve_prob orig (Some (formula)) [] wl)
in (solve env (attempt subprobs wl))))))
end
| _50_2974 -> begin
(let lhs = (force_refinement (base1, refinement1))
in (let rhs = (force_refinement (base2, refinement2))
in (solve_t env (let _50_2977 = problem
in {lhs = lhs; relation = _50_2977.relation; rhs = rhs; element = _50_2977.element; logical_guard = _50_2977.logical_guard; scope = _50_2977.scope; reason = _50_2977.reason; loc = _50_2977.loc; rank = _50_2977.rank}) wl)))
end)
end))
end))
end
end)
end))
end)))
end)
end))
end
| ((FStar_Absyn_Syntax.Typ_ascribed (_), _)) | ((FStar_Absyn_Syntax.Typ_meta (_), _)) | ((FStar_Absyn_Syntax.Typ_delayed (_), _)) | ((_, FStar_Absyn_Syntax.Typ_ascribed (_))) | ((_, FStar_Absyn_Syntax.Typ_meta (_))) | ((_, FStar_Absyn_Syntax.Typ_delayed (_))) -> begin
(FStar_All.failwith "Impossible")
end
| _50_3016 -> begin
(giveup env "head mismatch" orig)
end))))
end))
end)))))))
and solve_c : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.comp, Prims.unit) problem  ->  worklist  ->  solution = (fun env problem wl -> (let c1 = problem.lhs
in (let c2 = problem.rhs
in (let orig = CProb (problem)
in (let sub_prob = (fun t1 rel t2 reason -> (mk_problem (p_scope orig) orig t1 rel t2 None reason))
in (let solve_eq = (fun c1_comp c2_comp -> (let _50_3033 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("EQ"))) then begin
(FStar_Util.print_string "solve_c is using an equality constraint\n")
end else begin
()
end
in (let sub_probs = (FStar_List.map2 (fun arg1 arg2 -> (match (((Prims.fst arg1), (Prims.fst arg2))) with
| (FStar_Util.Inl (t1), FStar_Util.Inl (t2)) -> begin
(let _152_1404 = (sub_prob t1 EQ t2 "effect arg")
in (FStar_All.pipe_left (fun _152_1403 -> TProb (_152_1403)) _152_1404))
end
| (FStar_Util.Inr (e1), FStar_Util.Inr (e2)) -> begin
(let _152_1406 = (sub_prob e1 EQ e2 "effect arg")
in (FStar_All.pipe_left (fun _152_1405 -> EProb (_152_1405)) _152_1406))
end
| _50_3048 -> begin
(FStar_All.failwith "impossible")
end)) c1_comp.FStar_Absyn_Syntax.effect_args c2_comp.FStar_Absyn_Syntax.effect_args)
in (let guard = (let _152_1408 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) sub_probs)
in (FStar_Absyn_Util.mk_conj_l _152_1408))
in (let wl = (solve_prob orig (Some (guard)) [] wl)
in (solve env (attempt sub_probs wl)))))))
in if (FStar_Util.physical_equality c1 c2) then begin
(let _152_1409 = (solve_prob orig None [] wl)
in (solve env _152_1409))
end else begin
(let _50_3053 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1411 = (FStar_Absyn_Print.comp_typ_to_string c1)
in (let _152_1410 = (FStar_Absyn_Print.comp_typ_to_string c2)
in (FStar_Util.print3 "solve_c %s %s %s\n" _152_1411 (rel_to_string problem.relation) _152_1410)))
end else begin
()
end
in (let r = (FStar_Tc_Env.get_range env)
in (let _50_3058 = (c1, c2)
in (match (_50_3058) with
| (c1_0, c2_0) -> begin
(match ((c1.FStar_Absyn_Syntax.n, c2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Total (t1), FStar_Absyn_Syntax.Total (t2)) -> begin
(solve_t env (problem_using_guard orig t1 problem.relation t2 None "result type") wl)
end
| (FStar_Absyn_Syntax.Total (_50_3065), FStar_Absyn_Syntax.Comp (_50_3068)) -> begin
(let _152_1413 = (let _50_3071 = problem
in (let _152_1412 = (FStar_All.pipe_left FStar_Absyn_Syntax.mk_Comp (FStar_Absyn_Util.comp_to_comp_typ c1))
in {lhs = _152_1412; relation = _50_3071.relation; rhs = _50_3071.rhs; element = _50_3071.element; logical_guard = _50_3071.logical_guard; scope = _50_3071.scope; reason = _50_3071.reason; loc = _50_3071.loc; rank = _50_3071.rank}))
in (solve_c env _152_1413 wl))
end
| (FStar_Absyn_Syntax.Comp (_50_3074), FStar_Absyn_Syntax.Total (_50_3077)) -> begin
(let _152_1415 = (let _50_3080 = problem
in (let _152_1414 = (FStar_All.pipe_left FStar_Absyn_Syntax.mk_Comp (FStar_Absyn_Util.comp_to_comp_typ c2))
in {lhs = _50_3080.lhs; relation = _50_3080.relation; rhs = _152_1414; element = _50_3080.element; logical_guard = _50_3080.logical_guard; scope = _50_3080.scope; reason = _50_3080.reason; loc = _50_3080.loc; rank = _50_3080.rank}))
in (solve_c env _152_1415 wl))
end
| (FStar_Absyn_Syntax.Comp (_50_3083), FStar_Absyn_Syntax.Comp (_50_3086)) -> begin
if (((FStar_Absyn_Util.is_ml_comp c1) && (FStar_Absyn_Util.is_ml_comp c2)) || ((FStar_Absyn_Util.is_total_comp c1) && ((FStar_Absyn_Util.is_total_comp c2) || (FStar_Absyn_Util.is_ml_comp c2)))) then begin
(solve_t env (problem_using_guard orig (FStar_Absyn_Util.comp_result c1) problem.relation (FStar_Absyn_Util.comp_result c2) None "result type") wl)
end else begin
(let c1_comp = (FStar_Absyn_Util.comp_to_comp_typ c1)
in (let c2_comp = (FStar_Absyn_Util.comp_to_comp_typ c2)
in if ((problem.relation = EQ) && (FStar_Ident.lid_equals c1_comp.FStar_Absyn_Syntax.effect_name c2_comp.FStar_Absyn_Syntax.effect_name)) then begin
(solve_eq c1_comp c2_comp)
end else begin
(let c1 = (FStar_Tc_Normalize.weak_norm_comp env c1)
in (let c2 = (FStar_Tc_Normalize.weak_norm_comp env c2)
in (let _50_3093 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print2 "solve_c for %s and %s\n" c1.FStar_Absyn_Syntax.effect_name.FStar_Ident.str c2.FStar_Absyn_Syntax.effect_name.FStar_Ident.str)
end else begin
()
end
in (match ((FStar_Tc_Env.monad_leq env c1.FStar_Absyn_Syntax.effect_name c2.FStar_Absyn_Syntax.effect_name)) with
| None -> begin
(let _152_1418 = (let _152_1417 = (FStar_Absyn_Print.sli c1.FStar_Absyn_Syntax.effect_name)
in (let _152_1416 = (FStar_Absyn_Print.sli c2.FStar_Absyn_Syntax.effect_name)
in (FStar_Util.format2 "incompatible monad ordering: %s </: %s" _152_1417 _152_1416)))
in (giveup env _152_1418 orig))
end
| Some (edge) -> begin
if (problem.relation = EQ) then begin
(let _50_3113 = (match (c1.FStar_Absyn_Syntax.effect_args) with
| (FStar_Util.Inl (wp1), _50_3106)::(FStar_Util.Inl (wlp1), _50_3101)::[] -> begin
(wp1, wlp1)
end
| _50_3110 -> begin
(let _152_1420 = (let _152_1419 = (FStar_Range.string_of_range (FStar_Absyn_Syntax.range_of_lid c1.FStar_Absyn_Syntax.effect_name))
in (FStar_Util.format1 "Unexpected number of indices on a normalized effect (%s)" _152_1419))
in (FStar_All.failwith _152_1420))
end)
in (match (_50_3113) with
| (wp, wlp) -> begin
(let c1 = (let _152_1426 = (let _152_1425 = (let _152_1421 = (edge.FStar_Tc_Env.mlift c1.FStar_Absyn_Syntax.result_typ wp)
in (FStar_Absyn_Syntax.targ _152_1421))
in (let _152_1424 = (let _152_1423 = (let _152_1422 = (edge.FStar_Tc_Env.mlift c1.FStar_Absyn_Syntax.result_typ wlp)
in (FStar_Absyn_Syntax.targ _152_1422))
in (_152_1423)::[])
in (_152_1425)::_152_1424))
in {FStar_Absyn_Syntax.effect_name = c2.FStar_Absyn_Syntax.effect_name; FStar_Absyn_Syntax.result_typ = c1.FStar_Absyn_Syntax.result_typ; FStar_Absyn_Syntax.effect_args = _152_1426; FStar_Absyn_Syntax.flags = c1.FStar_Absyn_Syntax.flags})
in (solve_eq c1 c2))
end))
end else begin
(let is_null_wp_2 = (FStar_All.pipe_right c2.FStar_Absyn_Syntax.flags (FStar_Util.for_some (fun _50_33 -> (match (_50_33) with
| (FStar_Absyn_Syntax.TOTAL) | (FStar_Absyn_Syntax.MLEFFECT) | (FStar_Absyn_Syntax.SOMETRIVIAL) -> begin
true
end
| _50_3120 -> begin
false
end))))
in (let _50_3143 = (match ((c1.FStar_Absyn_Syntax.effect_args, c2.FStar_Absyn_Syntax.effect_args)) with
| ((FStar_Util.Inl (wp1), _50_3127)::_50_3123, (FStar_Util.Inl (wp2), _50_3135)::_50_3131) -> begin
(wp1, wp2)
end
| _50_3140 -> begin
(let _152_1430 = (let _152_1429 = (FStar_Absyn_Print.sli c1.FStar_Absyn_Syntax.effect_name)
in (let _152_1428 = (FStar_Absyn_Print.sli c2.FStar_Absyn_Syntax.effect_name)
in (FStar_Util.format2 "Got effects %s and %s, expected normalized effects" _152_1429 _152_1428)))
in (FStar_All.failwith _152_1430))
end)
in (match (_50_3143) with
| (wpc1, wpc2) -> begin
if (FStar_Util.physical_equality wpc1 wpc2) then begin
(solve_t env (problem_using_guard orig c1.FStar_Absyn_Syntax.result_typ problem.relation c2.FStar_Absyn_Syntax.result_typ None "result type") wl)
end else begin
(let c2_decl = (FStar_Tc_Env.get_effect_decl env c2.FStar_Absyn_Syntax.effect_name)
in (let g = if is_null_wp_2 then begin
(let _50_3145 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Util.print_string "Using trivial wp ... \n")
end else begin
()
end
in (let _152_1435 = (let _152_1434 = (let _152_1433 = (let _152_1432 = (let _152_1431 = (edge.FStar_Tc_Env.mlift c1.FStar_Absyn_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _152_1431))
in (_152_1432)::[])
in ((FStar_Absyn_Syntax.targ c1.FStar_Absyn_Syntax.result_typ))::_152_1433)
in (c2_decl.FStar_Absyn_Syntax.trivial, _152_1434))
in (FStar_Absyn_Syntax.mk_Typ_app _152_1435 (Some (FStar_Absyn_Syntax.ktype)) r)))
end else begin
(let wp2_imp_wp1 = (let _152_1445 = (let _152_1444 = (let _152_1443 = (let _152_1442 = (let _152_1441 = (let _152_1437 = (let _152_1436 = (FStar_Absyn_Const.kbin FStar_Absyn_Syntax.ktype FStar_Absyn_Syntax.ktype FStar_Absyn_Syntax.ktype)
in (FStar_Absyn_Util.ftv FStar_Absyn_Const.imp_lid _152_1436))
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _152_1437))
in (let _152_1440 = (let _152_1439 = (let _152_1438 = (edge.FStar_Tc_Env.mlift c1.FStar_Absyn_Syntax.result_typ wpc1)
in (FStar_All.pipe_left FStar_Absyn_Syntax.targ _152_1438))
in (_152_1439)::[])
in (_152_1441)::_152_1440))
in ((FStar_Absyn_Syntax.targ wpc2))::_152_1442)
in ((FStar_Absyn_Syntax.targ c2.FStar_Absyn_Syntax.result_typ))::_152_1443)
in (c2_decl.FStar_Absyn_Syntax.wp_binop, _152_1444))
in (FStar_Absyn_Syntax.mk_Typ_app _152_1445 None r))
in (FStar_Absyn_Syntax.mk_Typ_app (c2_decl.FStar_Absyn_Syntax.wp_as_type, ((FStar_Absyn_Syntax.targ c2.FStar_Absyn_Syntax.result_typ))::((FStar_Absyn_Syntax.targ wp2_imp_wp1))::[]) (Some (FStar_Absyn_Syntax.ktype)) r))
end
in (let base_prob = (let _152_1447 = (sub_prob c1.FStar_Absyn_Syntax.result_typ problem.relation c2.FStar_Absyn_Syntax.result_typ "result type")
in (FStar_All.pipe_left (fun _152_1446 -> TProb (_152_1446)) _152_1447))
in (let wl = (let _152_1451 = (let _152_1450 = (let _152_1449 = (FStar_All.pipe_right (p_guard base_prob) Prims.fst)
in (FStar_Absyn_Util.mk_conj _152_1449 g))
in (FStar_All.pipe_left (fun _152_1448 -> Some (_152_1448)) _152_1450))
in (solve_prob orig _152_1451 [] wl))
in (solve env (attempt ((base_prob)::[]) wl))))))
end
end)))
end
end))))
end))
end
end)
end))))
end))))))
and solve_e : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.exp, Prims.unit) problem  ->  worklist  ->  solution = (fun env problem wl -> (match ((compress_prob wl (EProb (problem)))) with
| EProb (p) -> begin
(solve_e' env p wl)
end
| _50_3157 -> begin
(FStar_All.failwith "Impossible")
end))
and solve_e' : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.exp, Prims.unit) problem  ->  worklist  ->  solution = (fun env problem wl -> (let problem = (let _50_3161 = problem
in {lhs = _50_3161.lhs; relation = EQ; rhs = _50_3161.rhs; element = _50_3161.element; logical_guard = _50_3161.logical_guard; scope = _50_3161.scope; reason = _50_3161.reason; loc = _50_3161.loc; rank = _50_3161.rank})
in (let e1 = problem.lhs
in (let e2 = problem.rhs
in (let orig = EProb (problem)
in (let sub_prob = (fun lhs rhs reason -> (mk_problem (p_scope orig) orig lhs EQ rhs None reason))
in (let _50_3173 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1461 = (prob_to_string env orig)
in (FStar_Util.print1 "Attempting:\n%s\n" _152_1461))
end else begin
()
end
in (let flex_rigid = (fun _50_3180 e2 -> (match (_50_3180) with
| (e1, u1, t1, args1) -> begin
(let maybe_vars1 = (pat_vars env [] args1)
in (let sub_problems = (fun xs args2 -> (let _50_3207 = (let _152_1477 = (FStar_All.pipe_right args2 (FStar_List.map (fun _50_34 -> (match (_50_34) with
| (FStar_Util.Inl (t), imp) -> begin
(let kk = (FStar_Tc_Recheck.recompute_kind t)
in (let _50_3194 = (new_tvar t.FStar_Absyn_Syntax.pos xs kk)
in (match (_50_3194) with
| (gi_xi, gi) -> begin
(let gi_pi = (FStar_Absyn_Syntax.mk_Typ_app' (gi, args1) (Some (kk)) t.FStar_Absyn_Syntax.pos)
in (let _152_1473 = (let _152_1472 = (sub_prob gi_pi t "type index")
in (FStar_All.pipe_left (fun _152_1471 -> TProb (_152_1471)) _152_1472))
in ((FStar_Util.Inl (gi_xi), imp), _152_1473)))
end)))
end
| (FStar_Util.Inr (v), imp) -> begin
(let tt = (FStar_Tc_Recheck.recompute_typ v)
in (let _50_3203 = (new_evar v.FStar_Absyn_Syntax.pos xs tt)
in (match (_50_3203) with
| (gi_xi, gi) -> begin
(let gi_pi = (FStar_Absyn_Syntax.mk_Exp_app' (gi, args1) (Some (tt)) v.FStar_Absyn_Syntax.pos)
in (let _152_1476 = (let _152_1475 = (sub_prob gi_pi v "expression index")
in (FStar_All.pipe_left (fun _152_1474 -> EProb (_152_1474)) _152_1475))
in ((FStar_Util.Inr (gi_xi), imp), _152_1476)))
end)))
end))))
in (FStar_All.pipe_right _152_1477 FStar_List.unzip))
in (match (_50_3207) with
| (gi_xi, gi_pi) -> begin
(let formula = (let _152_1479 = (FStar_List.map (fun p -> (FStar_All.pipe_right (p_guard p) Prims.fst)) gi_pi)
in (FStar_Absyn_Util.mk_conj_l _152_1479))
in (gi_xi, gi_pi, formula))
end)))
in (let project_e = (fun head2 args2 -> (let giveup = (fun reason -> (let _152_1486 = (FStar_Util.format1 "flex-rigid: refusing to project expressions (%s)" reason)
in (giveup env _152_1486 orig)))
in (match ((let _152_1487 = (FStar_Absyn_Util.compress_exp head2)
in _152_1487.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_bvar (y) -> begin
(let _50_3224 = (match ((FStar_Absyn_Util.function_formals t1)) with
| None -> begin
([], t1)
end
| Some (xs, c) -> begin
(xs, (FStar_Absyn_Util.comp_result c))
end)
in (match (_50_3224) with
| (all_xs, tres) -> begin
if ((FStar_List.length all_xs) <> (FStar_List.length args1)) then begin
(let _152_1490 = (let _152_1489 = (FStar_Absyn_Print.binders_to_string ", " all_xs)
in (let _152_1488 = (FStar_Absyn_Print.args_to_string args2)
in (FStar_Util.format2 "unequal arity:\n\texpetced binders %s\n\tgot args {%s}" _152_1489 _152_1488)))
in (giveup _152_1490))
end else begin
(let rec aux = (fun xs args -> (match ((xs, args)) with
| ([], []) -> begin
(giveup "variable to project not found")
end
| (([], _)) | ((_, [])) -> begin
(FStar_All.failwith "impossible")
end
| ((FStar_Util.Inl (_50_3241), _50_3244)::xs, (FStar_Util.Inl (_50_3249), _50_3252)::args) -> begin
(aux xs args)
end
| ((FStar_Util.Inr (xi), _50_3260)::xs, (FStar_Util.Inr (arg), _50_3267)::args) -> begin
(match ((let _152_1495 = (FStar_Absyn_Util.compress_exp arg)
in _152_1495.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Exp_bvar (z) -> begin
if (FStar_Absyn_Util.bvar_eq y z) then begin
(let _50_3276 = (sub_problems all_xs args2)
in (match (_50_3276) with
| (gi_xi, gi_pi, f) -> begin
(let sol = (let _152_1499 = (let _152_1498 = (let _152_1497 = (let _152_1496 = (FStar_Absyn_Util.bvar_to_exp xi)
in (_152_1496, gi_xi))
in (FStar_Absyn_Syntax.mk_Exp_app' _152_1497 None e1.FStar_Absyn_Syntax.pos))
in (all_xs, _152_1498))
in (FStar_Absyn_Syntax.mk_Exp_abs _152_1499 None e1.FStar_Absyn_Syntax.pos))
in (let _50_3278 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1503 = (FStar_Absyn_Print.uvar_e_to_string (u1, t1))
in (let _152_1502 = (FStar_Absyn_Print.exp_to_string sol)
in (let _152_1501 = (let _152_1500 = (FStar_All.pipe_right gi_pi (FStar_List.map (prob_to_string env)))
in (FStar_All.pipe_right _152_1500 (FStar_String.concat "\n")))
in (FStar_Util.print3 "Projected: %s -> %s\nSubprobs=\n%s\n" _152_1503 _152_1502 _152_1501))))
end else begin
()
end
in (let _152_1505 = (let _152_1504 = (solve_prob orig (Some (f)) ((UE (((u1, t1), sol)))::[]) wl)
in (attempt gi_pi _152_1504))
in (solve env _152_1505))))
end))
end else begin
(aux xs args)
end
end
| _50_3281 -> begin
(aux xs args)
end)
end
| (x::xs, arg::args) -> begin
(let _152_1508 = (let _152_1507 = (FStar_Absyn_Print.binder_to_string x)
in (let _152_1506 = (FStar_Absyn_Print.arg_to_string arg)
in (FStar_Util.format2 "type incorrect term---impossible: expected %s; got %s\n" _152_1507 _152_1506)))
in (giveup _152_1508))
end))
in (aux (FStar_List.rev all_xs) (FStar_List.rev args1)))
end
end))
end
| _50_3290 -> begin
(giveup "rigid head term is not a variable")
end)))
in (let imitate_or_project_e = (fun _50_3292 -> (match (()) with
| () -> begin
if wl.defer_ok then begin
(solve env (defer "flex-rigid: not a pattern" orig wl))
end else begin
(let _50_3293 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1512 = (FStar_Absyn_Print.exp_to_string e1)
in (let _152_1511 = (FStar_Absyn_Print.exp_to_string e2)
in (FStar_Util.print2 "Imitating expressions: %s =?= %s\n" _152_1512 _152_1511)))
end else begin
()
end
in (let _50_3297 = (FStar_Absyn_Util.head_and_args_e e2)
in (match (_50_3297) with
| (head2, args2) -> begin
(let fvhead = (FStar_Absyn_Util.freevars_exp head2)
in (let _50_3302 = (occurs_check_e env (u1, t1) head2)
in (match (_50_3302) with
| (occurs_ok, _50_3301) -> begin
if ((FStar_Absyn_Util.fvs_included fvhead FStar_Absyn_Syntax.no_fvs) && occurs_ok) then begin
(let _50_3310 = (match ((FStar_Absyn_Util.function_formals t1)) with
| None -> begin
([], t1)
end
| Some (xs, c) -> begin
(xs, (FStar_Absyn_Util.comp_result c))
end)
in (match (_50_3310) with
| (xs, tres) -> begin
(let _50_3314 = (sub_problems xs args2)
in (match (_50_3314) with
| (gi_xi, gi_pi, f) -> begin
(let sol = (let body = (FStar_Absyn_Syntax.mk_Exp_app' (head2, gi_xi) None e1.FStar_Absyn_Syntax.pos)
in (match (xs) with
| [] -> begin
body
end
| _50_3318 -> begin
(let _152_1514 = (let _152_1513 = (FStar_Absyn_Syntax.mk_Exp_app' (head2, gi_xi) None e1.FStar_Absyn_Syntax.pos)
in (xs, _152_1513))
in (FStar_Absyn_Syntax.mk_Exp_abs _152_1514 None e1.FStar_Absyn_Syntax.pos))
end))
in (let _50_3320 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1518 = (FStar_Absyn_Print.uvar_e_to_string (u1, t1))
in (let _152_1517 = (FStar_Absyn_Print.exp_to_string sol)
in (let _152_1516 = (let _152_1515 = (FStar_All.pipe_right gi_pi (FStar_List.map (prob_to_string env)))
in (FStar_All.pipe_right _152_1515 (FStar_String.concat "\n")))
in (FStar_Util.print3 "Imitated: %s -> %s\nSubprobs=\n%s\n" _152_1518 _152_1517 _152_1516))))
end else begin
()
end
in (let _152_1520 = (let _152_1519 = (solve_prob orig (Some (f)) ((UE (((u1, t1), sol)))::[]) wl)
in (attempt gi_pi _152_1519))
in (solve env _152_1520))))
end))
end))
end else begin
if occurs_ok then begin
(project_e head2 args2)
end else begin
(giveup env "flex-rigid: occurs check failed" orig)
end
end
end)))
end)))
end
end))
in (match (maybe_vars1) with
| (None) | (Some ([])) -> begin
(imitate_or_project_e ())
end
| Some (xs) -> begin
(let fvs1 = (FStar_Absyn_Syntax.freevars_of_binders xs)
in (let fvs2 = (FStar_Absyn_Util.freevars_exp e2)
in (let _50_3332 = (occurs_check_e env (u1, t1) e2)
in (match (_50_3332) with
| (occurs_ok, _50_3331) -> begin
if (((FStar_Util.set_is_subset_of fvs2.FStar_Absyn_Syntax.ftvs fvs1.FStar_Absyn_Syntax.ftvs) && (FStar_Util.set_is_subset_of fvs2.FStar_Absyn_Syntax.fxvs fvs1.FStar_Absyn_Syntax.fxvs)) && occurs_ok) then begin
(let sol = (FStar_Absyn_Syntax.mk_Exp_abs' (xs, e2) None e1.FStar_Absyn_Syntax.pos)
in (let _152_1521 = (solve_prob orig None ((UE (((u1, t1), sol)))::[]) wl)
in (solve env _152_1521)))
end else begin
(imitate_or_project_e ())
end
end))))
end)))))
end))
in (let flex_flex = (fun _50_3339 _50_3344 -> (match ((_50_3339, _50_3344)) with
| ((e1, u1, t1, args1), (e2, u2, t2, args2)) -> begin
(let maybe_vars1 = (pat_vars env [] args1)
in (let maybe_vars2 = (pat_vars env [] args2)
in (match ((maybe_vars1, maybe_vars2)) with
| ((None, _)) | ((_, None)) -> begin
if wl.defer_ok then begin
(solve env (defer "flex-flex: not a pattern" orig wl))
end else begin
(giveup env "flex-flex expressions not patterns" orig)
end
end
| (Some (xs), Some (ys)) -> begin
if ((FStar_Unionfind.equivalent u1 u2) && (binders_eq xs ys)) then begin
(solve env wl)
end else begin
(let zs = (intersect_vars xs ys)
in (let tt = (FStar_Tc_Recheck.recompute_typ e2)
in (let _50_3365 = (new_evar (FStar_Tc_Env.get_range env) zs tt)
in (match (_50_3365) with
| (u, _50_3364) -> begin
(let sub1 = (match (xs) with
| [] -> begin
u
end
| _50_3368 -> begin
(FStar_Absyn_Syntax.mk_Exp_abs (xs, u) (Some (t1)) e1.FStar_Absyn_Syntax.pos)
end)
in (let sub2 = (match (ys) with
| [] -> begin
u
end
| _50_3372 -> begin
(FStar_Absyn_Syntax.mk_Exp_abs (ys, u) (Some (t2)) e1.FStar_Absyn_Syntax.pos)
end)
in (let _152_1526 = (solve_prob orig None ((UE (((u1, t1), sub1)))::(UE (((u2, t2), sub2)))::[]) wl)
in (solve env _152_1526))))
end))))
end
end)))
end))
in (let smt_fallback = (fun e1 e2 -> if wl.smt_ok then begin
(let _50_3377 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1531 = (prob_to_string env orig)
in (FStar_Util.print1 "Using SMT to solve:\n%s\n" _152_1531))
end else begin
()
end
in (let _50_3382 = (let _152_1532 = (FStar_Tc_Env.binders env)
in (new_tvar (FStar_Tc_Env.get_range env) _152_1532 FStar_Absyn_Syntax.ktype))
in (match (_50_3382) with
| (t, _50_3381) -> begin
(let _152_1536 = (let _152_1535 = (let _152_1534 = (FStar_Absyn_Util.mk_eq t t e1 e2)
in (FStar_All.pipe_left (fun _152_1533 -> Some (_152_1533)) _152_1534))
in (solve_prob orig _152_1535 [] wl))
in (solve env _152_1536))
end)))
end else begin
(giveup env "no SMT solution permitted" orig)
end)
in (match ((e1.FStar_Absyn_Syntax.n, e2.FStar_Absyn_Syntax.n)) with
| (FStar_Absyn_Syntax.Exp_ascribed (e1, _50_3385, _50_3387), _50_3391) -> begin
(solve_e env (let _50_3393 = problem
in {lhs = e1; relation = _50_3393.relation; rhs = _50_3393.rhs; element = _50_3393.element; logical_guard = _50_3393.logical_guard; scope = _50_3393.scope; reason = _50_3393.reason; loc = _50_3393.loc; rank = _50_3393.rank}) wl)
end
| (_50_3396, FStar_Absyn_Syntax.Exp_ascribed (e2, _50_3399, _50_3401)) -> begin
(solve_e env (let _50_3405 = problem
in {lhs = _50_3405.lhs; relation = _50_3405.relation; rhs = e2; element = _50_3405.element; logical_guard = _50_3405.logical_guard; scope = _50_3405.scope; reason = _50_3405.reason; loc = _50_3405.loc; rank = _50_3405.rank}) wl)
end
| ((FStar_Absyn_Syntax.Exp_uvar (_), FStar_Absyn_Syntax.Exp_uvar (_))) | ((FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), FStar_Absyn_Syntax.Exp_uvar (_))) | ((FStar_Absyn_Syntax.Exp_uvar (_), FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) | ((FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) -> begin
(let _152_1538 = (destruct_flex_e e1)
in (let _152_1537 = (destruct_flex_e e2)
in (flex_flex _152_1538 _152_1537)))
end
| ((FStar_Absyn_Syntax.Exp_uvar (_), _)) | ((FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _), _)) -> begin
(let _152_1539 = (destruct_flex_e e1)
in (flex_rigid _152_1539 e2))
end
| ((_, FStar_Absyn_Syntax.Exp_uvar (_))) | ((_, FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_uvar (_); FStar_Absyn_Syntax.tk = _; FStar_Absyn_Syntax.pos = _; FStar_Absyn_Syntax.fvs = _; FStar_Absyn_Syntax.uvs = _}, _))) -> begin
(let _152_1540 = (destruct_flex_e e2)
in (flex_rigid _152_1540 e1))
end
| (FStar_Absyn_Syntax.Exp_bvar (x1), FStar_Absyn_Syntax.Exp_bvar (x1')) -> begin
if (FStar_Absyn_Util.bvd_eq x1.FStar_Absyn_Syntax.v x1'.FStar_Absyn_Syntax.v) then begin
(let _152_1541 = (solve_prob orig None [] wl)
in (solve env _152_1541))
end else begin
(let _152_1547 = (let _152_1546 = (let _152_1545 = (let _152_1544 = (FStar_Tc_Recheck.recompute_typ e1)
in (let _152_1543 = (FStar_Tc_Recheck.recompute_typ e2)
in (FStar_Absyn_Util.mk_eq _152_1544 _152_1543 e1 e2)))
in (FStar_All.pipe_left (fun _152_1542 -> Some (_152_1542)) _152_1545))
in (solve_prob orig _152_1546 [] wl))
in (solve env _152_1547))
end
end
| (FStar_Absyn_Syntax.Exp_fvar (fv1, _50_3544), FStar_Absyn_Syntax.Exp_fvar (fv1', _50_3549)) -> begin
if (FStar_Ident.lid_equals fv1.FStar_Absyn_Syntax.v fv1'.FStar_Absyn_Syntax.v) then begin
(let _152_1548 = (solve_prob orig None [] wl)
in (solve env _152_1548))
end else begin
(giveup env "free-variables unequal" orig)
end
end
| (FStar_Absyn_Syntax.Exp_constant (s1), FStar_Absyn_Syntax.Exp_constant (s1')) -> begin
(let const_eq = (fun s1 s2 -> (match ((s1, s2)) with
| (FStar_Const.Const_bytearray (b1, _50_3563), FStar_Const.Const_bytearray (b2, _50_3568)) -> begin
(b1 = b2)
end
| (FStar_Const.Const_string (b1, _50_3574), FStar_Const.Const_string (b2, _50_3579)) -> begin
(b1 = b2)
end
| _50_3584 -> begin
(s1 = s2)
end))
in if (const_eq s1 s1') then begin
(let _152_1553 = (solve_prob orig None [] wl)
in (solve env _152_1553))
end else begin
(giveup env "constants unequal" orig)
end)
end
| (FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (_50_3594); FStar_Absyn_Syntax.tk = _50_3592; FStar_Absyn_Syntax.pos = _50_3590; FStar_Absyn_Syntax.fvs = _50_3588; FStar_Absyn_Syntax.uvs = _50_3586}, _50_3598), _50_3602) -> begin
(let _152_1555 = (let _50_3604 = problem
in (let _152_1554 = (whnf_e env e1)
in {lhs = _152_1554; relation = _50_3604.relation; rhs = _50_3604.rhs; element = _50_3604.element; logical_guard = _50_3604.logical_guard; scope = _50_3604.scope; reason = _50_3604.reason; loc = _50_3604.loc; rank = _50_3604.rank}))
in (solve_e env _152_1555 wl))
end
| (_50_3607, FStar_Absyn_Syntax.Exp_app ({FStar_Absyn_Syntax.n = FStar_Absyn_Syntax.Exp_abs (_50_3617); FStar_Absyn_Syntax.tk = _50_3615; FStar_Absyn_Syntax.pos = _50_3613; FStar_Absyn_Syntax.fvs = _50_3611; FStar_Absyn_Syntax.uvs = _50_3609}, _50_3621)) -> begin
(let _152_1557 = (let _50_3625 = problem
in (let _152_1556 = (whnf_e env e2)
in {lhs = _50_3625.lhs; relation = _50_3625.relation; rhs = _152_1556; element = _50_3625.element; logical_guard = _50_3625.logical_guard; scope = _50_3625.scope; reason = _50_3625.reason; loc = _50_3625.loc; rank = _50_3625.rank}))
in (solve_e env _152_1557 wl))
end
| (FStar_Absyn_Syntax.Exp_app (head1, args1), FStar_Absyn_Syntax.Exp_app (head2, args2)) -> begin
(let orig_wl = wl
in (let rec solve_args = (fun sub_probs wl args1 args2 -> (match ((args1, args2)) with
| ([], []) -> begin
(let guard = (let _152_1567 = (let _152_1566 = (FStar_List.map p_guard sub_probs)
in (FStar_All.pipe_right _152_1566 (FStar_List.map Prims.fst)))
in (FStar_Absyn_Util.mk_conj_l _152_1567))
in (let g = (simplify_formula env guard)
in (let g = (FStar_Absyn_Util.compress_typ g)
in (match (g.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (fv) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.true_lid) -> begin
(let _152_1568 = (solve_prob orig None wl.subst (let _50_3650 = orig_wl
in {attempting = _50_3650.attempting; wl_deferred = _50_3650.wl_deferred; subst = []; ctr = _50_3650.ctr; slack_vars = _50_3650.slack_vars; defer_ok = _50_3650.defer_ok; smt_ok = _50_3650.smt_ok; tcenv = _50_3650.tcenv}))
in (solve env _152_1568))
end
| _50_3653 -> begin
(let _50_3657 = (let _152_1569 = (FStar_Tc_Env.binders env)
in (new_tvar (FStar_Tc_Env.get_range env) _152_1569 FStar_Absyn_Syntax.ktype))
in (match (_50_3657) with
| (t, _50_3656) -> begin
(let guard = (let _152_1570 = (FStar_Absyn_Util.mk_eq t t e1 e2)
in (FStar_Absyn_Util.mk_disj g _152_1570))
in (let _152_1571 = (solve_prob orig (Some (guard)) wl.subst (let _50_3659 = orig_wl
in {attempting = _50_3659.attempting; wl_deferred = _50_3659.wl_deferred; subst = []; ctr = _50_3659.ctr; slack_vars = _50_3659.slack_vars; defer_ok = _50_3659.defer_ok; smt_ok = _50_3659.smt_ok; tcenv = _50_3659.tcenv}))
in (solve env _152_1571)))
end))
end))))
end
| (arg1::rest1, arg2::rest2) -> begin
(let prob = (match (((Prims.fst arg1), (Prims.fst arg2))) with
| (FStar_Util.Inl (t1), FStar_Util.Inl (t2)) -> begin
(let _152_1573 = (mk_problem (p_scope orig) orig t1 EQ t2 None "expression type arg")
in (FStar_All.pipe_left (fun _152_1572 -> TProb (_152_1572)) _152_1573))
end
| (FStar_Util.Inr (e1), FStar_Util.Inr (e2)) -> begin
(let _152_1575 = (mk_problem (p_scope orig) orig e1 EQ e2 None "expression arg")
in (FStar_All.pipe_left (fun _152_1574 -> EProb (_152_1574)) _152_1575))
end
| _50_3679 -> begin
(FStar_All.failwith "Impossible: ill-typed expression")
end)
in (match ((solve env (let _50_3681 = wl
in {attempting = (prob)::[]; wl_deferred = []; subst = _50_3681.subst; ctr = _50_3681.ctr; slack_vars = _50_3681.slack_vars; defer_ok = false; smt_ok = false; tcenv = _50_3681.tcenv}))) with
| Failed (_50_3684) -> begin
(smt_fallback e1 e2)
end
| Success (subst, _50_3688) -> begin
(solve_args ((prob)::sub_probs) (let _50_3691 = wl
in {attempting = _50_3691.attempting; wl_deferred = _50_3691.wl_deferred; subst = subst; ctr = _50_3691.ctr; slack_vars = _50_3691.slack_vars; defer_ok = _50_3691.defer_ok; smt_ok = _50_3691.smt_ok; tcenv = _50_3691.tcenv}) rest1 rest2)
end))
end
| _50_3694 -> begin
(FStar_All.failwith "Impossible: lengths defer")
end))
in (let rec match_head_and_args = (fun head1 head2 -> (match ((let _152_1583 = (let _152_1580 = (FStar_Absyn_Util.compress_exp head1)
in _152_1580.FStar_Absyn_Syntax.n)
in (let _152_1582 = (let _152_1581 = (FStar_Absyn_Util.compress_exp head2)
in _152_1581.FStar_Absyn_Syntax.n)
in (_152_1583, _152_1582)))) with
| (FStar_Absyn_Syntax.Exp_bvar (x), FStar_Absyn_Syntax.Exp_bvar (y)) when ((FStar_Absyn_Util.bvar_eq x y) && ((FStar_List.length args1) = (FStar_List.length args2))) -> begin
(solve_args [] wl args1 args2)
end
| (FStar_Absyn_Syntax.Exp_fvar (f, _50_3705), FStar_Absyn_Syntax.Exp_fvar (g, _50_3710)) when (((FStar_Absyn_Util.fvar_eq f g) && (not ((FStar_Absyn_Util.is_interpreted f.FStar_Absyn_Syntax.v)))) && ((FStar_List.length args1) = (FStar_List.length args2))) -> begin
(solve_args [] wl args1 args2)
end
| (FStar_Absyn_Syntax.Exp_ascribed (e, _50_3716, _50_3718), _50_3722) -> begin
(match_head_and_args e head2)
end
| (_50_3725, FStar_Absyn_Syntax.Exp_ascribed (e, _50_3728, _50_3730)) -> begin
(match_head_and_args head1 e)
end
| (FStar_Absyn_Syntax.Exp_abs (_50_3735), _50_3738) -> begin
(let _152_1585 = (let _50_3740 = problem
in (let _152_1584 = (whnf_e env e1)
in {lhs = _152_1584; relation = _50_3740.relation; rhs = _50_3740.rhs; element = _50_3740.element; logical_guard = _50_3740.logical_guard; scope = _50_3740.scope; reason = _50_3740.reason; loc = _50_3740.loc; rank = _50_3740.rank}))
in (solve_e env _152_1585 wl))
end
| (_50_3743, FStar_Absyn_Syntax.Exp_abs (_50_3745)) -> begin
(let _152_1587 = (let _50_3748 = problem
in (let _152_1586 = (whnf_e env e2)
in {lhs = _50_3748.lhs; relation = _50_3748.relation; rhs = _152_1586; element = _50_3748.element; logical_guard = _50_3748.logical_guard; scope = _50_3748.scope; reason = _50_3748.reason; loc = _50_3748.loc; rank = _50_3748.rank}))
in (solve_e env _152_1587 wl))
end
| _50_3751 -> begin
(smt_fallback e1 e2)
end))
in (match_head_and_args head1 head2))))
end
| _50_3753 -> begin
(let _50_3757 = (let _152_1588 = (FStar_Tc_Env.binders env)
in (new_tvar (FStar_Tc_Env.get_range env) _152_1588 FStar_Absyn_Syntax.ktype))
in (match (_50_3757) with
| (t, _50_3756) -> begin
(let guard = (FStar_Absyn_Util.mk_eq t t e1 e2)
in (let _50_3759 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1589 = (FStar_Absyn_Print.typ_to_string guard)
in (FStar_Util.print1 "Emitting guard %s\n" _152_1589))
end else begin
()
end
in (let _152_1593 = (let _152_1592 = (let _152_1591 = (FStar_Absyn_Util.mk_eq t t e1 e2)
in (FStar_All.pipe_left (fun _152_1590 -> Some (_152_1590)) _152_1591))
in (solve_prob orig _152_1592 [] wl))
in (solve env _152_1593))))
end))
end)))))))))))

# 2355 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type guard_formula =
| Trivial
| NonTrivial of FStar_Absyn_Syntax.formula

# 2356 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Trivial : guard_formula  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| Trivial -> begin
true
end
| _ -> begin
false
end))

# 2357 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_NonTrivial : guard_formula  ->  Prims.bool = (fun _discr_ -> (match (_discr_) with
| NonTrivial (_) -> begin
true
end
| _ -> begin
false
end))

# 2357 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let ___NonTrivial____0 : guard_formula  ->  FStar_Absyn_Syntax.formula = (fun projectee -> (match (projectee) with
| NonTrivial (_50_3763) -> begin
_50_3763
end))

# 2359 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type implicits =
((FStar_Absyn_Syntax.uvar_t * FStar_Range.range), (FStar_Absyn_Syntax.uvar_e * FStar_Range.range)) FStar_Util.either Prims.list

# 2360 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

type guard_t =
{guard_f : guard_formula; deferred : deferred; implicits : implicits}

# 2360 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_Mkguard_t : guard_t  ->  Prims.bool = (Obj.magic ((fun _ -> (FStar_All.failwith "Not yet implemented:is_Mkguard_t"))))

# 2366 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let guard_to_string : FStar_Tc_Env.env  ->  guard_t  ->  Prims.string = (fun env g -> (let form = (match (g.guard_f) with
| Trivial -> begin
"trivial"
end
| NonTrivial (f) -> begin
if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(FStar_Tc_Normalize.formula_norm_to_string env f)
end else begin
"non-trivial"
end
end)
in (let carry = (let _152_1624 = (FStar_List.map (fun _50_3777 -> (match (_50_3777) with
| (_50_3775, x) -> begin
(prob_to_string env x)
end)) g.deferred.carry)
in (FStar_All.pipe_right _152_1624 (FStar_String.concat ",\n")))
in (FStar_Util.format2 "\n\t{guard_f=%s;\n\t deferred={\n%s};}\n" form carry))))

# 2379 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let guard_of_guard_formula : guard_formula  ->  guard_t = (fun g -> {guard_f = g; deferred = {carry = []; slack = []}; implicits = []})

# 2381 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let guard_form : guard_t  ->  guard_formula = (fun g -> g.guard_f)

# 2383 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let is_trivial : guard_t  ->  Prims.bool = (fun g -> (match (g) with
| {guard_f = Trivial; deferred = {carry = []; slack = []}; implicits = _50_3783} -> begin
true
end
| _50_3790 -> begin
false
end))

# 2387 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let trivial_guard : guard_t = {guard_f = Trivial; deferred = {carry = []; slack = []}; implicits = []}

# 2389 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let abstract_guard : FStar_Absyn_Syntax.bvvar  ->  guard_t Prims.option  ->  guard_t Prims.option = (fun x g -> (match (g) with
| (None) | (Some ({guard_f = Trivial; deferred = _; implicits = _})) -> begin
g
end
| Some (g) -> begin
(let f = (match (g.guard_f) with
| NonTrivial (f) -> begin
f
end
| _50_3806 -> begin
(FStar_All.failwith "impossible")
end)
in (let _152_1638 = (let _50_3808 = g
in (let _152_1637 = (let _152_1636 = (FStar_Absyn_Syntax.mk_Typ_lam (((FStar_Absyn_Syntax.v_binder x))::[], f) None f.FStar_Absyn_Syntax.pos)
in (FStar_All.pipe_left (fun _152_1635 -> NonTrivial (_152_1635)) _152_1636))
in {guard_f = _152_1637; deferred = _50_3808.deferred; implicits = _50_3808.implicits}))
in Some (_152_1638)))
end))

# 2398 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let apply_guard : guard_t  ->  (FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  guard_t = (fun g e -> (match (g.guard_f) with
| Trivial -> begin
g
end
| NonTrivial (f) -> begin
(let _50_3815 = g
in (let _152_1646 = (let _152_1645 = (FStar_All.pipe_left (FStar_Absyn_Syntax.syn f.FStar_Absyn_Syntax.pos (Some (FStar_Absyn_Syntax.ktype))) (FStar_Absyn_Syntax.mk_Typ_app (f, ((FStar_Absyn_Syntax.varg e))::[])))
in NonTrivial (_152_1645))
in {guard_f = _152_1646; deferred = _50_3815.deferred; implicits = _50_3815.implicits}))
end))

# 2402 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let trivial : guard_formula  ->  Prims.unit = (fun t -> (match (t) with
| Trivial -> begin
()
end
| NonTrivial (_50_3820) -> begin
(FStar_All.failwith "impossible")
end))

# 2406 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let conj_guard_f : guard_formula  ->  guard_formula  ->  guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| ((Trivial, g)) | ((g, Trivial)) -> begin
g
end
| (NonTrivial (f1), NonTrivial (f2)) -> begin
(let _152_1653 = (FStar_Absyn_Util.mk_conj f1 f2)
in NonTrivial (_152_1653))
end))

# 2411 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let check_trivial : (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  guard_formula = (fun t -> (match (t.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (tc) when (FStar_Ident.lid_equals tc.FStar_Absyn_Syntax.v FStar_Absyn_Const.true_lid) -> begin
Trivial
end
| _50_3838 -> begin
NonTrivial (t)
end))

# 2415 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let imp_guard_f : guard_formula  ->  guard_formula  ->  guard_formula = (fun g1 g2 -> (match ((g1, g2)) with
| (Trivial, g) -> begin
g
end
| (g, Trivial) -> begin
Trivial
end
| (NonTrivial (f1), NonTrivial (f2)) -> begin
(let imp = (FStar_Absyn_Util.mk_imp f1 f2)
in (check_trivial imp))
end))

# 2421 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let binop_guard : (guard_formula  ->  guard_formula  ->  guard_formula)  ->  guard_t  ->  guard_t  ->  guard_t = (fun f g1 g2 -> (let _152_1676 = (f g1.guard_f g2.guard_f)
in {guard_f = _152_1676; deferred = {carry = (FStar_List.append g1.deferred.carry g2.deferred.carry); slack = (FStar_List.append g1.deferred.slack g2.deferred.slack)}; implicits = (FStar_List.append g1.implicits g2.implicits)}))

# 2425 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let conj_guard : guard_t  ->  guard_t  ->  guard_t = (fun g1 g2 -> (binop_guard conj_guard_f g1 g2))

# 2426 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let imp_guard : guard_t  ->  guard_t  ->  guard_t = (fun g1 g2 -> (binop_guard imp_guard_f g1 g2))

# 2428 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let close_guard : FStar_Absyn_Syntax.binder Prims.list  ->  guard_t  ->  guard_t = (fun binders g -> (match (g.guard_f) with
| Trivial -> begin
g
end
| NonTrivial (f) -> begin
(let _50_3865 = g
in (let _152_1691 = (let _152_1690 = (FStar_Absyn_Util.close_forall binders f)
in (FStar_All.pipe_right _152_1690 (fun _152_1689 -> NonTrivial (_152_1689))))
in {guard_f = _152_1691; deferred = _50_3865.deferred; implicits = _50_3865.implicits}))
end))

# 2432 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let mk_guard = (fun g ps slack locs -> {guard_f = g; deferred = {carry = ps; slack = slack}; implicits = []})

# 2441 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_t_problem = (fun env lhs rel rhs elt loc -> (let reason = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _152_1703 = (FStar_Tc_Normalize.typ_norm_to_string env lhs)
in (let _152_1702 = (FStar_Tc_Normalize.typ_norm_to_string env rhs)
in (FStar_Util.format3 "Top-level:\n%s\n\t%s\n%s" _152_1703 (rel_to_string rel) _152_1702)))
end else begin
"TOP"
end
in (let p = (new_problem env lhs rel rhs elt loc reason)
in p)))

# 2448 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_t_prob : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  rel  ->  FStar_Absyn_Syntax.typ  ->  (prob * ((FStar_Absyn_Syntax.exp', (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax FStar_Absyn_Syntax.bvdef, FStar_Absyn_Syntax.typ) FStar_Absyn_Syntax.withinfo_t) = (fun env t1 rel t2 -> (let x = (FStar_Absyn_Util.gen_bvar_p (FStar_Tc_Env.get_range env) t1)
in (let env = (FStar_Tc_Env.push_local_binding env (FStar_Tc_Env.Binding_var ((x.FStar_Absyn_Syntax.v, x.FStar_Absyn_Syntax.sort))))
in (let p = (let _152_1714 = (let _152_1713 = (FStar_Absyn_Util.bvar_to_exp x)
in (FStar_All.pipe_left (fun _152_1712 -> Some (_152_1712)) _152_1713))
in (new_t_problem env t1 rel t2 _152_1714 (FStar_Tc_Env.get_range env)))
in (TProb (p), x)))))

# 2454 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let new_k_problem = (fun env lhs rel rhs elt loc -> (let reason = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _152_1722 = (FStar_Tc_Normalize.kind_norm_to_string env lhs)
in (let _152_1721 = (FStar_Tc_Normalize.kind_norm_to_string env rhs)
in (FStar_Util.format3 "Top-level:\n%s\n\t%s\n%s" _152_1722 (rel_to_string rel) _152_1721)))
end else begin
"TOP"
end
in (let p = (new_problem env lhs rel rhs elt loc reason)
in p)))

# 2461 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let simplify_guard : FStar_Tc_Env.env  ->  guard_t  ->  guard_t = (fun env g -> (match (g.guard_f) with
| Trivial -> begin
g
end
| NonTrivial (f) -> begin
(let _50_3899 = if (FStar_Tc_Env.debug env FStar_Options.High) then begin
(let _152_1727 = (FStar_Absyn_Print.typ_to_string f)
in (FStar_Util.print1 "Simplifying guard %s\n" _152_1727))
end else begin
()
end
in (let f = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Simplify)::[]) env f)
in (let f = (match (f.FStar_Absyn_Syntax.n) with
| FStar_Absyn_Syntax.Typ_const (fv) when (FStar_Ident.lid_equals fv.FStar_Absyn_Syntax.v FStar_Absyn_Const.true_lid) -> begin
Trivial
end
| _50_3905 -> begin
NonTrivial (f)
end)
in (let _50_3907 = g
in {guard_f = f; deferred = _50_3907.deferred; implicits = _50_3907.implicits}))))
end))

# 2471 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let solve_and_commit : FStar_Tc_Env.env  ->  worklist  ->  ((prob * Prims.string)  ->  deferred Prims.option)  ->  deferred Prims.option = (fun env probs err -> (let probs = if (FStar_ST.read FStar_Options.eager_inference) then begin
(let _50_3912 = probs
in {attempting = _50_3912.attempting; wl_deferred = _50_3912.wl_deferred; subst = _50_3912.subst; ctr = _50_3912.ctr; slack_vars = _50_3912.slack_vars; defer_ok = false; smt_ok = _50_3912.smt_ok; tcenv = _50_3912.tcenv})
end else begin
probs
end
in (let sol = (solve env probs)
in (match (sol) with
| Success (s, deferred) -> begin
(let _50_3920 = (commit env s)
in Some (deferred))
end
| Failed (d, s) -> begin
(let _50_3926 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("ExplainRel"))) then begin
(let _152_1739 = (explain env d s)
in (FStar_All.pipe_left FStar_Util.print_string _152_1739))
end else begin
()
end
in (err (d, s)))
end))))

# 2483 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let with_guard : FStar_Tc_Env.env  ->  prob  ->  deferred Prims.option  ->  guard_t Prims.option = (fun env prob dopt -> (match (dopt) with
| None -> begin
None
end
| Some (d) -> begin
(let _152_1751 = (let _152_1750 = (let _152_1749 = (let _152_1748 = (FStar_All.pipe_right (p_guard prob) Prims.fst)
in (FStar_All.pipe_right _152_1748 (fun _152_1747 -> NonTrivial (_152_1747))))
in {guard_f = _152_1749; deferred = d; implicits = []})
in (simplify_guard env _152_1750))
in (FStar_All.pipe_left (fun _152_1746 -> Some (_152_1746)) _152_1751))
end))

# 2488 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let try_keq : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.knd  ->  FStar_Absyn_Syntax.knd  ->  guard_t Prims.option = (fun env k1 k2 -> (let _50_3937 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1759 = (FStar_Absyn_Print.kind_to_string k1)
in (let _152_1758 = (FStar_Absyn_Print.kind_to_string k2)
in (FStar_Util.print2 "try_keq of %s and %s\n" _152_1759 _152_1758)))
end else begin
()
end
in (let prob = (let _152_1763 = (let _152_1762 = (FStar_Tc_Normalize.norm_kind ((FStar_Tc_Normalize.Beta)::[]) env k1)
in (let _152_1761 = (FStar_Tc_Normalize.norm_kind ((FStar_Tc_Normalize.Beta)::[]) env k2)
in (new_k_problem env _152_1762 EQ _152_1761 None (FStar_Tc_Env.get_range env))))
in (FStar_All.pipe_left (fun _152_1760 -> KProb (_152_1760)) _152_1763))
in (let _152_1765 = (solve_and_commit env (singleton env prob) (fun _50_3940 -> None))
in (FStar_All.pipe_left (with_guard env prob) _152_1765)))))

# 2494 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let keq : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax Prims.option  ->  FStar_Absyn_Syntax.knd  ->  FStar_Absyn_Syntax.knd  ->  guard_t = (fun env t k1 k2 -> (match ((try_keq env k1 k2)) with
| None -> begin
(let r = (match (t) with
| None -> begin
(FStar_Tc_Env.get_range env)
end
| Some (t) -> begin
t.FStar_Absyn_Syntax.pos
end)
in (match (t) with
| None -> begin
(let _152_1776 = (let _152_1775 = (let _152_1774 = (FStar_Tc_Errors.incompatible_kinds env k2 k1)
in (_152_1774, r))
in FStar_Absyn_Syntax.Error (_152_1775))
in (Prims.raise _152_1776))
end
| Some (t) -> begin
(let _152_1779 = (let _152_1778 = (let _152_1777 = (FStar_Tc_Errors.expected_typ_of_kind env k2 t k1)
in (_152_1777, r))
in FStar_Absyn_Syntax.Error (_152_1778))
in (Prims.raise _152_1779))
end))
end
| Some (g) -> begin
g
end))

# 2506 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let subkind : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.knd  ->  FStar_Absyn_Syntax.knd  ->  guard_t = (fun env k1 k2 -> (let _50_3959 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1788 = (FStar_All.pipe_left FStar_Range.string_of_range (FStar_Tc_Env.get_range env))
in (let _152_1787 = (FStar_Absyn_Print.kind_to_string k1)
in (let _152_1786 = (FStar_Absyn_Print.kind_to_string k2)
in (FStar_Util.print3 "(%s) subkind of %s and %s\n" _152_1788 _152_1787 _152_1786))))
end else begin
()
end
in (let prob = (let _152_1792 = (let _152_1791 = (whnf_k env k1)
in (let _152_1790 = (whnf_k env k2)
in (new_k_problem env _152_1791 SUB _152_1790 None (FStar_Tc_Env.get_range env))))
in (FStar_All.pipe_left (fun _152_1789 -> KProb (_152_1789)) _152_1792))
in (let res = (let _152_1798 = (let _152_1797 = (solve_and_commit env (singleton env prob) (fun _50_3962 -> (let _152_1796 = (let _152_1795 = (let _152_1794 = (FStar_Tc_Errors.incompatible_kinds env k1 k2)
in (_152_1794, (FStar_Tc_Env.get_range env)))
in FStar_Absyn_Syntax.Error (_152_1795))
in (Prims.raise _152_1796))))
in (FStar_All.pipe_left (with_guard env prob) _152_1797))
in (FStar_Util.must _152_1798))
in res))))

# 2517 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let try_teq : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  guard_t Prims.option = (fun env t1 t2 -> (let _50_3968 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1806 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1805 = (FStar_Absyn_Print.typ_to_string t2)
in (FStar_Util.print2 "try_teq of %s and %s\n" _152_1806 _152_1805)))
end else begin
()
end
in (let prob = (let _152_1808 = (new_t_problem env t1 EQ t2 None (FStar_Tc_Env.get_range env))
in (FStar_All.pipe_left (fun _152_1807 -> TProb (_152_1807)) _152_1808))
in (let g = (let _152_1810 = (solve_and_commit env (singleton env prob) (fun _50_3971 -> None))
in (FStar_All.pipe_left (with_guard env prob) _152_1810))
in g))))

# 2524 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let teq : FStar_Tc_Env.env  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  (FStar_Absyn_Syntax.typ', (FStar_Absyn_Syntax.knd', Prims.unit) FStar_Absyn_Syntax.syntax) FStar_Absyn_Syntax.syntax  ->  guard_t = (fun env t1 t2 -> (match ((try_teq env t1 t2)) with
| None -> begin
(let _152_1819 = (let _152_1818 = (let _152_1817 = (FStar_Tc_Errors.basic_type_error env None t2 t1)
in (_152_1817, (FStar_Tc_Env.get_range env)))
in FStar_Absyn_Syntax.Error (_152_1818))
in (Prims.raise _152_1819))
end
| Some (g) -> begin
(let _50_3980 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1822 = (FStar_Absyn_Print.typ_to_string t1)
in (let _152_1821 = (FStar_Absyn_Print.typ_to_string t2)
in (let _152_1820 = (guard_to_string env g)
in (FStar_Util.print3 "teq of %s and %s succeeded with guard %s\n" _152_1822 _152_1821 _152_1820))))
end else begin
()
end
in g)
end))

# 2531 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let try_subtype : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ  ->  guard_t Prims.option = (fun env t1 t2 -> (let kopt = (fun _50_35 -> (match (_50_35) with
| None -> begin
"None"
end
| Some (t) -> begin
(FStar_Absyn_Print.kind_to_string t)
end))
in (let k = (fun t1 -> (match ((let _152_1833 = (FStar_Absyn_Util.compress_typ t1)
in _152_1833.FStar_Absyn_Syntax.n)) with
| FStar_Absyn_Syntax.Typ_const (x) -> begin
(let _152_1837 = (let _152_1834 = (FStar_Absyn_Print.kind_to_string x.FStar_Absyn_Syntax.sort)
in (Prims.strcat _152_1834 " ... "))
in (let _152_1836 = (let _152_1835 = (FStar_ST.read t1.FStar_Absyn_Syntax.tk)
in (kopt _152_1835))
in (Prims.strcat _152_1837 _152_1836)))
end
| _50_3995 -> begin
(let _152_1838 = (FStar_ST.read t1.FStar_Absyn_Syntax.tk)
in (kopt _152_1838))
end))
in (let _50_3996 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1842 = (FStar_Tc_Normalize.typ_norm_to_string env t1)
in (let _152_1841 = (k t1)
in (let _152_1840 = (FStar_Tc_Normalize.typ_norm_to_string env t2)
in (let _152_1839 = (k t2)
in (FStar_Util.print4 "try_subtype of %s : %s and %s : %s\n" _152_1842 _152_1841 _152_1840 _152_1839)))))
end else begin
()
end
in (let _50_4000 = (new_t_prob env t1 SUB t2)
in (match (_50_4000) with
| (prob, x) -> begin
(let g = (let _152_1844 = (solve_and_commit env (singleton env prob) (fun _50_4001 -> None))
in (FStar_All.pipe_left (with_guard env prob) _152_1844))
in (let _50_4004 = if ((FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) && (FStar_Util.is_some g)) then begin
(let _152_1848 = (FStar_Tc_Normalize.typ_norm_to_string env t1)
in (let _152_1847 = (FStar_Tc_Normalize.typ_norm_to_string env t2)
in (let _152_1846 = (let _152_1845 = (FStar_Util.must g)
in (guard_to_string env _152_1845))
in (FStar_Util.print3 "try_subtype succeeded: %s <: %s\n\tguard is %s\n" _152_1848 _152_1847 _152_1846))))
end else begin
()
end
in (abstract_guard x g)))
end))))))

# 2551 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let subtype_fail = (fun env t1 t2 -> (let _152_1854 = (let _152_1853 = (let _152_1852 = (FStar_Tc_Errors.basic_type_error env None t2 t1)
in (_152_1852, (FStar_Tc_Env.get_range env)))
in FStar_Absyn_Syntax.Error (_152_1853))
in (Prims.raise _152_1854)))

# 2554 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let subtype : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.typ  ->  FStar_Absyn_Syntax.typ  ->  guard_t = (fun env t1 t2 -> (match ((try_subtype env t1 t2)) with
| Some (f) -> begin
f
end
| None -> begin
(subtype_fail env t1 t2)
end))

# 2559 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let sub_comp : FStar_Tc_Env.env  ->  FStar_Absyn_Syntax.comp  ->  FStar_Absyn_Syntax.comp  ->  guard_t Prims.option = (fun env c1 c2 -> (let _50_4018 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1868 = (FStar_Absyn_Print.comp_typ_to_string c1)
in (let _152_1867 = (FStar_Absyn_Print.comp_typ_to_string c2)
in (FStar_Util.print2 "sub_comp of %s and %s\n" _152_1868 _152_1867)))
end else begin
()
end
in (let rel = if env.FStar_Tc_Env.use_eq then begin
EQ
end else begin
SUB
end
in (let prob = (let _152_1870 = (new_problem env c1 rel c2 None (FStar_Tc_Env.get_range env) "sub_comp")
in (FStar_All.pipe_left (fun _152_1869 -> CProb (_152_1869)) _152_1870))
in (let _152_1872 = (solve_and_commit env (singleton env prob) (fun _50_4022 -> None))
in (FStar_All.pipe_left (with_guard env prob) _152_1872))))))

# 2566 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let solve_deferred_constraints : FStar_Tc_Env.env  ->  guard_t  ->  guard_t = (fun env g -> (let fail = (fun _50_4029 -> (match (_50_4029) with
| (d, s) -> begin
(let msg = (explain env d s)
in (Prims.raise (FStar_Absyn_Syntax.Error ((msg, (p_loc d))))))
end))
in (let _50_4034 = if ((FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) && ((FStar_List.length g.deferred.carry) <> 0)) then begin
(let _152_1885 = (let _152_1884 = (FStar_All.pipe_right g.deferred.carry (FStar_List.map (fun _50_4033 -> (match (_50_4033) with
| (msg, x) -> begin
(let _152_1883 = (FStar_All.pipe_left FStar_Range.string_of_range (p_loc x))
in (let _152_1882 = (prob_to_string env x)
in (let _152_1881 = (let _152_1880 = (FStar_All.pipe_right (p_guard x) Prims.fst)
in (FStar_Tc_Normalize.formula_norm_to_string env _152_1880))
in (FStar_Util.format4 "(At %s) %s\n%s\nguard is %s\n" _152_1883 msg _152_1882 _152_1881))))
end))))
in (FStar_All.pipe_right _152_1884 (FStar_String.concat "\n")))
in (FStar_All.pipe_left (FStar_Util.print1 "Trying to solve carried problems: begin\n%s\nend\n") _152_1885))
end else begin
()
end
in (let gopt = (let _152_1886 = (wl_of_guard env g.deferred)
in (solve_and_commit env _152_1886 fail))
in (match (gopt) with
| Some ({carry = _50_4039; slack = slack}) -> begin
(let _50_4042 = (fix_slack_vars slack)
in (let _50_4044 = g
in {guard_f = _50_4044.guard_f; deferred = no_deferred; implicits = _50_4044.implicits}))
end
| _50_4047 -> begin
(FStar_All.failwith "impossible")
end)))))

# 2584 "D:\\workspace\\universes\\FStar\\src\\tc\\rel.fs"

let try_discharge_guard : FStar_Tc_Env.env  ->  guard_t  ->  Prims.unit = (fun env g -> (let g = (solve_deferred_constraints env g)
in if (not ((FStar_Options.should_verify env.FStar_Tc_Env.curmodule.FStar_Ident.str))) then begin
()
end else begin
(match (g.guard_f) with
| Trivial -> begin
()
end
| NonTrivial (vc) -> begin
(let vc = (FStar_Tc_Normalize.norm_typ ((FStar_Tc_Normalize.DeltaHard)::(FStar_Tc_Normalize.Beta)::(FStar_Tc_Normalize.Eta)::(FStar_Tc_Normalize.Simplify)::[]) env vc)
in (match ((check_trivial vc)) with
| Trivial -> begin
()
end
| NonTrivial (vc) -> begin
(let _50_4058 = if (FStar_All.pipe_left (FStar_Tc_Env.debug env) (FStar_Options.Other ("Rel"))) then begin
(let _152_1892 = (let _152_1891 = (FStar_Absyn_Print.formula_to_string vc)
in (FStar_Util.format1 "Checking VC=\n%s\n" _152_1891))
in (FStar_Tc_Errors.diag (FStar_Tc_Env.get_range env) _152_1892))
end else begin
()
end
in (env.FStar_Tc_Env.solver.FStar_Tc_Env.solve env vc))
end))
end)
end))




