
Type.createNamespace('SCORM_1_2'); SCORM_1_2.ActivityTreeNode = function() { this.$1 = []; this.$E = {}; this.$F = SCORM_1_2.API_LIB.defaulT_LESSON_STATUS; this.$11 = []; }
SCORM_1_2.ActivityTreeNode.prototype = {
	$0: 0, $2: null, $3: null, $4: null, $5: null, $6: null, $7: false, $8: true, $9: null, $A: null, $B: null, $C: null, $D: null, $10: null, addNode: function(title, identifier, url, scormType, isvisible) { var $0 = new SCORM_1_2.ActivityTreeNode(); $0.$2 = this; $0.$3 = title; $0.$4 = identifier; $0.$5 = url; $0.$6 = scormType; $0.$7 = isvisible; $0.$11.add('exit'); $0.$11.add('abandon'); $0.$11.add('abandonall'); $0.$11.add('suspendall'); this.$1.add($0); return $0; }, getChildrens: function() { return this.$1; }, isLeaf: function() { return this.getChildrensCount() === 0; }, getParent: function() { return this.$2; }, getRoot: function() { if (this.$2 == null) { return (Type.canCast(this, SCORM_1_2.ActivityTree)) ? this : null; } else { return this.$2.getRoot(); } }, getPath: function(toNode, inclusiveThis, inclusiveTo, reverse) { throw new Error('Not implemented!'); }, getLevel: function() { throw new Error('Not implemented!'); }, getOrderIndex: function() { return this.$0; }, setOrderIndex: function(orderIndex) { this.$0 = orderIndex; }, getChildrensCount: function() { return this.$1.length; }, isVisible: function() { return this.$7; }, isEnabled: function() { return this.$8; }, setEnabled: function(enabled) { this.$8 = enabled; }, getTitle: function() { return this.$3; }, setTitle: function(title) { this.$3 = title; }, setMaxtimeallowed: function(maxtimeallowed) { this.$9 = maxtimeallowed; }, getMaxtimeallowed: function() { return this.$9; }, setTimelimitaction: function(timelimitaction) { this.$A = timelimitaction; }, getTimelimitaction: function() { return this.$A; }, setDatafromlms: function(datafromlms) { this.$B = datafromlms; }, getDatafromlms: function() { return this.$B; }, setPrerequisites: function(prerequisites) { this.$D = prerequisites; }, getPrerequisites: function() { return this.$D; }, setMasteryscore: function(masteryscore) { this.$C = masteryscore; }, getMasteryscore: function() { return this.$C; }, getUrl: function() { return this.$5; }, getScormType: function() { return this.$6; }, getHideLMSUI: function() { return this.$11; }, getIdentifier: function() { return this.$4; }, getLessonstatus: function() { return this.$F; }, setLessonstatus: function(lessonstatus) { this.$F = lessonstatus; if (this.getRoot() != null) { this.getRoot().getStoredStatuses()[this.getIdentifier()] = lessonstatus; } }, getNextNode: function() {
		var $0 = null; var $1 = false; this.getRoot().scan(this.getRoot().getOrganization(), Delegate.create(this, function($p1_0) {
			if (!$1) { $1 = ($p1_0 === this); } else { $0 = $p1_0; return false; } return true;
		}), null); return $0;
	}, getPrevNode: function() {
		var $0 = null; var $1 = null; this.getRoot().scan(this.getRoot().getOrganization(), Delegate.create(this, function($p1_0) {
			if ($p1_0 !== this) { $1 = $p1_0; } else { $0 = $1; return false; } return true;
		}), null); return $0;
	}, setData: function(data) { this.$10 = data; }, getData: function() { return this.$10; }, getDataTree: function() { return this.$E; }, setDataTree: function(dataTree) { this.$E = dataTree; }, setDataTreeValue: function(dataElement, value, isSetBySCO) { var $0 = this.$E[dataElement]; if (!isUndefined($0)) { $0['value'] = value; if (isSetBySCO) { $0['setbysco'] = true; } } else { this.$E[dataElement] = { value: value, setbysco: isSetBySCO }; } }, getDataTreeValue: function(dataElement) { var $0 = this.$E[dataElement]; if (isUndefined($0)) { return undefined; } return $0['value']; }
}
SCORM_1_2.ActivityTree = function(selectedOrganizationIdentifier, storedStatuses, isScormAuto) { SCORM_1_2.ActivityTree.constructBase(this); this.$12 = selectedOrganizationIdentifier; if (storedStatuses != null) { this.$17 = storedStatuses; } else { this.$17 = {}; } this.$13 = isScormAuto; }
SCORM_1_2.ActivityTree.prototype = {
	$12: null, $13: false, $14: false, $15: 0, $16: null, $17: null, $18: null, $19: false, $1A: false, $1B: null, add_eventSCO: function(value) { this.$1B = Delegate.combine(this.$1B, value); }, remove_eventSCO: function(value) { this.$1B = Delegate.remove(this.$1B, value); }, onEventSCO: function(e) { if (this.$1B != null && !this.$19) { this.$1B.invoke(this, e); } }, hasPrerequisites: function() { return this.$1A; }, $1C: function($p0) { API_BASE.LOG.silent = true; var $0 = null; var $1 = null; var $2 = null; if (this.$1A && isNullOrUndefined(this.getActiveAPI())) { $2 = this.getActiveAPI().getActivityTreeNode(); $0 = $2.getLessonstatus(); $1 = $2.getDataTreeValue('cmi.core.lesson_status'); if ($1 === $0) { $2 = null; } } this.$19 = true; try { if ($2 != null) { $2.setLessonstatus($1); this.reEvaluate(); } this.requestNavigation($p0); } finally { this.$19 = false; API_BASE.LOG.silent = false; if ($2 != null) { $2.setLessonstatus($0); this.reEvaluate(); } } return this.$18; }, isValidNavigationRequest: function(validationNavigationRequest) { return this.$1C(validationNavigationRequest) != null; }, findCommonParent: function(currentNode, targetNode) { throw new Error('Not implemented!'); }, scan: function(node, scanCallback, scanSkipCallback) { if (scanSkipCallback != null && scanSkipCallback.invoke(node)) { return true; } if (!scanCallback.invoke(node)) { return false; } var $enum1 = node.getChildrens().getEnumerator(); while ($enum1.moveNext()) { var $0 = $enum1.get_current(); if (!this.scan($0, scanCallback, scanSkipCallback)) { return false; } } return true; }, getOrganization: function() { var $0 = this.getChildrens(); if ($0.length <= 0) { return null; } var $1 = $0[0]; if (this.$12 != null) { var $enum1 = $0.getEnumerator(); while ($enum1.moveNext()) { var $2 = $enum1.get_current(); if ($2.getIdentifier() === this.$12) { $1 = $2; break; } } } return $1; }, $1D: function($p0) { return ($p0.getUrl() != null && $p0.isEnabled()); }, getFirstAvailableSCO: function() {
		var $0 = null; var $1 = null; var $2 = null; this.scan(this.getOrganization(), Delegate.create(this, function($p1_0) {
			if (this.$1D($p1_0)) { if ($0 == null) { $0 = $p1_0; } if ($2 == null && ($p1_0).getLessonstatus() === 'incomplete') { $2 = $p1_0; return false; } else if ($1 == null && ($p1_0).getLessonstatus() === 'not attempted') { $1 = $p1_0; } } return true;
		}), null); return ($2 != null) ? $2 : ($1 != null) ? $1 : $0;
	}, getActiveAPI: function() { return this.$16; }, setActiveAPI: function(activeAPI) { this.$16 = activeAPI; API.setAPI_LIB(this.$16); }, isScormAuto: function() { return this.$13; }, isSingleItem: function() { return this.$14; }, getStoredStatuses: function() { return this.$17; }, requestNavigation: function(navigationRequest) { if (!this.$19 && this.getActiveAPI() != null && this.getActiveAPI().isInitAttempted() && !this.getActiveAPI().isFinishAttempted()) { this.getActiveAPI().getActivityTreeNode().setDataTreeValue('nav.event', navigationRequest, false); this.onEventSCO(new API_BASE.BaseActivityTreeNodeEventArgs(null, 3)); } else { API_BASE.LOG.displayMessage('Process Navigation: ' + navigationRequest, '0', null); this.$18 = null; var $0 = null; if (navigationRequest === 'start') { $0 = this.getFirstAvailableSCO(); } else if (navigationRequest === 'continue') { $0 = this.$1E(); } else if (navigationRequest === 'previous') { $0 = this.$1F(); } else if (navigationRequest.endsWith('}choice')) { var $1 = navigationRequest.match(new RegExp('^{target=(' + API_BASE.BaseUtils.ncName + ')}choice$')); if ($1 != null && $1.length >= 2 && !isNullOrUndefined($1[1]) && $1[1].length > 0) { $0 = this.$20($1[1]); } } else if (navigationRequest === 'exitAll') { this.onEventSCO(new API_BASE.BaseActivityTreeNodeEventArgs(null, 5)); return; } this.$18 = $0; if (!this.$19 && $0 != null) { this.onEventSCO(new API_BASE.BaseActivityTreeNodeEventArgs($0, 2)); } } }, $1E: function() { if (this.$16 == null) { return null; } var $0 = this.$16.getActivityTreeNode(); if ($0 == null) { return null; } var $1 = $0.getNextNode(); while ($1 != null) { if (this.$1D($1)) { return $1; } $1 = $1.getNextNode(); } return null; }, $1F: function() { if (this.getActiveAPI() == null) { return null; } var $0 = this.$16.getActivityTreeNode(); if ($0 == null) { return null; } var $1 = $0.getPrevNode(); while ($1 != null) { if (this.$1D($1)) { return $1; } $1 = $1.getPrevNode(); } return null; }, $20: function($p0) {
		var $0 = null; if (isNullOrUndefined($p0)) { return null; } this.scan(this.getOrganization(), Delegate.create(this, function($p1_0) {
			if ($p1_0.getIdentifier() === $p0) { if (this.$1D($p1_0)) { $0 = $p1_0; } return false; } return true;
		}), null); return $0;
	}, reEvaluate: function() {
		this.scan(this.getOrganization(), Delegate.create(this, function($p1_0) {
			var $1_0 = $p1_0; var $1_1 = $1_0.getPrerequisites(); $1_0.setEnabled(isNullOrUndefined($1_1) || this.evaluatePrerequisites($1_1)); return true;
		}), null);
	}, $21: function($p0) {
		var $0 = null; if (!isNullOrUndefined($p0) && $p0.length > 0) {
			this.scan(this.getOrganization(), Delegate.create(this, function($p1_0) {
				if ($p1_0.getIdentifier() === $p0) { $0 = $p1_0; return false; } return true;
			}), null);
		} return $0;
	}, evaluatePrerequisites: function(prerequisites) { try { prerequisites = prerequisites.replace(new RegExp('&amp;', 'g'), '&'); prerequisites = prerequisites.replace(new RegExp('\t', 'g'), ' '); prerequisites = prerequisites.replace(new RegExp('(&|\\||\\(|\\)|\\~)', 'g'), '\t$1\t'); prerequisites = prerequisites.replace(new RegExp('&', 'g'), '&&'); prerequisites = prerequisites.replace(new RegExp('\\|', 'g'), '||'); var $0 = prerequisites.trim().split('\t'); var $1 = ''; var $enum1 = $0.getEnumerator(); while ($enum1.moveNext()) { var $2 = $enum1.get_current(); var $3 = $2.trim(); if (isNullOrUndefined($3) || $3.length <= 0) { continue; } if ($3.match(new RegExp('^(&&|\\|\\||\\(|\\))$', 'g')) == null) { var $4 = $3.match(new RegExp('^(\\d+)\\*\\{(.+)\\}$')); if ($4 != null && $4.length >= 3) { var $5 = parseInt($4[1]); var $6 = $4[2].split(','); var $7 = 0; var $enum2 = $6.getEnumerator(); while ($enum2.moveNext()) { var $8 = $enum2.get_current(); var $9 = this.$21($8.trim()); if ($9 != null && ($9.getLessonstatus() === 'completed' || $9.getLessonstatus() === 'passed')) { $7++; } } if ($7 >= $5) { $3 = 'true'; } else { $3 = 'false'; } } else if ($3 === '~') { $3 = '!'; } else { $4 = $3.match(new RegExp('^(.+)(\\=|\\<\\>)(.+)$')); if ($4 != null && $4.length >= 3 && !isNullOrUndefined($4[1])) { $3 = $4[1].trim(); var $A = this.$21($3); if ($A != null) { var $B = { passed: 'passed', completed: 'completed', failed: 'failed', incomplete: 'incomplete', browsed: 'browsed', not_attempted: 'not attempted', p: 'passed', c: 'completed', f: 'failed', i: 'incomplete', b: 'browsed', n: 'not attempted' }; var $C = $4[3].replace(new RegExp('(\'|\")', 'g'), ''); $C = $C.trim().replace(' ', '_'); if (Object.keyExists($B, $C)) { $C = $B[$C]; } var $D = '=='; if ($4[2] === '<>') { $D = '!='; } $3 = '(\'' + $A.getLessonstatus() + '\' ' + $D + ' \'' + $C + '\')'; } else { $3 = 'false'; } } else { var $E = this.$21($3); if ($E != null && ($E.getLessonstatus() === 'completed' || $E.getLessonstatus() === 'passed')) { $3 = 'true'; } else { $3 = 'false'; } } } } $1 += ' ' + $3 + ' '; } return eval($1); } catch ($F) { return false; } }, initByManifest: function(manifestPath, imsmanifest) { if (isNullOrUndefined(imsmanifest)) { return; } var $0 = imsmanifest.getElementsByTagName('manifest'); if (isNullOrUndefined($0) || $0.length !== 1) { return; } var $1 = API_BASE.BaseUtils.getXMLNodeAttribut($0[0], 'base'); if (!isNullOrUndefined($1) && !$1.endsWith('/')) { $1 += '/'; } if (!isNullOrUndefined(manifestPath) && manifestPath.length > 0) { if (!manifestPath.endsWith('/')) { manifestPath += '/'; } $1 = manifestPath + ((!isNullOrUndefined($1)) ? $1 : ''); } var $2 = imsmanifest.getElementsByTagName('organization'); if (isNullOrUndefined($2) || $2.length <= 0) { return; } var $3 = imsmanifest.getElementsByTagName('resources'); var $4 = null; var $5 = ''; if (!isNullOrUndefined($3) && $3.length === 1) { var $7 = API_BASE.BaseUtils.getXMLNodeAttribut($3[0], 'base'); if (!isNullOrUndefined($7) && !$7.endsWith('/')) { $7 += '/'; } if (!isNullOrUndefined($1)) { $5 = $1; } if (!isNullOrUndefined($7)) { if (!$7.startsWith('/')) { $5 += $7; } else { $5 = API_BASE.BaseUtils.getBaseOfUrl($5) + $7; } } $4 = imsmanifest.getElementsByTagName('resource'); } var $6 = false; if (!isNullOrUndefined(this.$12) && this.$12.length > 0) { for (var $8 = 0; $8 < $2.length; $8++) { var $9 = $2[$8]; var $A = API_BASE.BaseUtils.getXMLNodeAttribut($9, 'identifier'); if ($A === this.$12) { $6 = true; this.$22(this, $9, $4, $5, true); break; } } } if (!$6) { this.$22(this, $2[0], $4, $5, true); } this.reEvaluate(); }, $22: function($p0, $p1, $p2, $p3, $p4) { var $0 = API_BASE.BaseUtils.getXMLNodeAttribut($p1, 'identifier'); var $1 = API_BASE.BaseUtils.getXMLNodeAttribut($p1, 'identifierref'); var $2 = null; var $3 = true; var $4 = null; if (!$p4) { if ($1 != null && $1.length > 0 && !isNullOrUndefined($p2) && $p2.length >= 1) { for (var $6 = 0; $6 < $p2.length; $6++) { var $7 = API_BASE.BaseUtils.getXMLNodeAttribut($p2[$6], 'identifier'); if ($7 != null && $7 === $1) { $4 = API_BASE.BaseUtils.getXMLNodeAttribut($p2[$6], 'scormtype'); if (!isNullOrUndefined($4)) { $4 = $4.toLowerCase(); } $2 = API_BASE.BaseUtils.getXMLNodeAttribut($p2[$6], 'href'); if ($2 == null) { $2 = ''; } while ($2.startsWith('/')) { $2 = $2.substr(1); } var $8 = API_BASE.BaseUtils.getXMLNodeAttribut($p2[$6], 'base'); if ($8 != null && $8.length > 0 && !$2.startsWith('http://') && !$2.startsWith('https://')) { if (!$8.endsWith('/')) { $8 += '/'; } if (!$8.startsWith('/')) { $p3 += $8; } else { $p3 = API_BASE.BaseUtils.getBaseOfUrl($p3) + $8; } } $2 = $p3 + $2; while ($2.startsWith('/')) { $2 = $2.substr(1); } $2 = API_BASE.BaseUtils.utf8Decode($2); var $9 = API_BASE.BaseUtils.getXMLNodeAttribut($p1, 'parameters'); if ($9 == null || $9.length <= 0) { break; } $2 = API_BASE.BaseUtils.addParameters($2, $9); break; } } } $3 = API_BASE.BaseUtils.getXMLNodeAttribut($p1, 'isvisible') == null || API_BASE.BaseUtils.getXMLNodeAttribut($p1, 'isvisible') === 'true'; } var $5; if ($p4) { $5 = $p0.addNode('', $0, null, $4, $3); } else { $5 = $p0.addNode('', $0, $2, $4, $3); this.$14 = this.$15 === 1; } $5.setOrderIndex(this.$15); this.$15++; for (var $A = 0; $A < $p1.childNodes.length; $A++) { if ($p1.childNodes[$A].nodeType !== 1) { continue; } var $B = API_BASE.BaseUtils.getBaseName($p1.childNodes[$A]).toLowerCase(); var $C = API_BASE.BaseUtils.getText($p1.childNodes[$A]); if ($B === 'title') { $5.setTitle($C); } else if ($B === 'maxtimeallowed') { $5.setMaxtimeallowed($C); } else if ($B === 'timelimitaction') { $5.setTimelimitaction($C); } else if ($B === 'datafromlms') { $5.setDatafromlms($C); } else if ($B === 'masteryscore') { $5.setMasteryscore($C); } else if ($B === 'prerequisites') { this.$1A = true; $5.setPrerequisites($C); } else if ($B === 'item') { this.$22($5, $p1.childNodes[$A], $p2, $p3, false); } } if (!isNullOrUndefined(this.$17[$5.getIdentifier()])) { $5.setLessonstatus(this.$17[$5.getIdentifier()]); } }
}
SCORM_1_2.API_LIB = function(activityTreeNode) { this.$1F = activityTreeNode; if (this.$1F.getRoot() != null) { this.$20 = this.$1F.getRoot().isScormAuto(); } this.$23 = '0'; this.$1E = {}; this.$0 = '^[\\u0000-\\uffff]{0,255}$'; this.$1 = '^[\\u0000-\\uffff]{0,4096}$'; this.$2 = '^([0-2]{1}[0-9]{1}):([0-5]{1}[0-9]{1}):([0-5]{1}[0-9]{1})(\.[0-9]{1,2})?$'; this.$3 = '^([0-9]{2,4}):([0-9]{2}):([0-9]{2})(\.[0-9]{1,2})?$'; this.$4 = '^\\d+$'; this.$5 = '^-?([0-9]+)$'; this.$6 = '^-?([0-9]{0,3})(\.[0-9]{1,2})?$'; this.$7 = '^\\w{1,255}$'; this.$8 = this.$0; this.$9 = '[._](\\d+).'; this.$A = '^passed$|^completed$|^failed$|^incomplete$|^browsed$'; this.$B = '^passed$|^completed$|^failed$|^incomplete$|^browsed$|^not attempted$'; this.$C = '^time-out$|^suspend$|^logout$|^$'; this.$D = '^true-false$|^choice$|^fill-in$|^matching$|^performance$|^sequencing$|^likert$|^numeric$'; this.$E = '^correct$|^wrong$|^unanticipated$|^neutral$|^([0-9]{0,3})?(\.[0-9]{1,2})?$'; this.$F = '^previous$|^continue$|^exitAll$|^{target=' + API_BASE.BaseUtils.ncName + '}choice$'; this.$10 = 'core, suspend_data, launch_data, comments, objectives, student_data, student_preference, interactions'; this.$11 = 'student_id, student_name, lesson_location, credit, lesson_status, entry, score, total_time, lesson_mode, exit, session_time'; this.$12 = 'raw, min, max'; this.$13 = 'content, location, time'; this.$14 = 'id, score, status'; this.$15 = 'pattern'; this.$16 = 'mastery_score, max_time_allowed, time_limit_action'; this.$17 = 'audio, language, speed, text'; this.$18 = 'id, objectives, time, type, correct_responses, weighting, student_response, result, latency'; this.$19 = '0#100'; this.$1A = '-1#100'; this.$1B = '-100#100'; this.$1C = '-100#100'; this.$1D = '-1#1'; this.$1E['cmi._children'] = { defaultvalue: this.$10, mod: 'r', writeerror: '402' }; this.$1E['cmi._version'] = { defaultvalue: '3.4', mod: 'r', writeerror: '402' }; this.$1E['cmi.core._children'] = { defaultvalue: this.$11, mod: 'r', writeerror: '402' }; this.$1E['cmi.core.student_id'] = { defaultvalue: '', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.student_name'] = { defaultvalue: '', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.lesson_location'] = { defaultvalue: '', format: this.$0, mod: 'rw', writeerror: '405' }; this.$1E['cmi.core.credit'] = { defaultvalue: 'credit', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.lesson_status'] = { defaultvalue: SCORM_1_2.API_LIB.defaulT_LESSON_STATUS, format: this.$A, mod: 'rw', writeerror: '405' }; this.$1E['cmi.core.entry'] = { defaultvalue: 'ab-initio', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.score._children'] = { defaultvalue: this.$12, mod: 'r', writeerror: '402' }; this.$1E['cmi.core.score.raw'] = { defaultvalue: '', format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.core.score.max'] = { defaultvalue: '', format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.core.score.min'] = { defaultvalue: '', format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.core.total_time'] = { defaultvalue: '0000:00:00.00', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.lesson_mode'] = { defaultvalue: 'normal', mod: 'r', writeerror: '403' }; this.$1E['cmi.core.exit'] = { defaultvalue: null, format: this.$C, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.core.session_time'] = { defaultvalue: null, format: this.$3, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.suspend_data'] = { defaultvalue: '', format: this.$1, mod: 'rw', writeerror: '405' }; this.$1E['cmi.launch_data'] = { defaultvalue: (activityTreeNode.getDatafromlms() == null) ? '' : activityTreeNode.getDatafromlms(), mod: 'r', writeerror: '403' }; this.$1E['cmi.comments'] = { defaultvalue: '', format: this.$1, mod: 'rw', writeerror: '405' }; this.$1E['cmi.comments_from_lms'] = { mod: 'r', writeerror: '403' }; this.$1E['cmi.evaluation.comments._count'] = { defaultvalue: '0', mod: 'r', writeerror: '402' }; this.$1E['cmi.evaluation.comments._children'] = { defaultvalue: this.$13, mod: 'r', writeerror: '402' }; this.$1E['cmi.evaluation.comments.n.content'] = { defaultvalue: '', pattern: this.$9, format: this.$0, mod: 'rw', writeerror: '405' }; this.$1E['cmi.evaluation.comments.n.location'] = { defaultvalue: '', pattern: this.$9, format: this.$0, mod: 'rw', writeerror: '405' }; this.$1E['cmi.evaluation.comments.n.time'] = { defaultvalue: '', pattern: this.$9, format: this.$2, mod: 'rw', writeerror: '405' }; this.$1E['cmi.objectives._children'] = { defaultvalue: this.$14, mod: 'r', writeerror: '402' }; this.$1E['cmi.objectives._count'] = { defaultvalue: '0', mod: 'r', writeerror: '402' }; this.$1E['cmi.objectives.n.id'] = { defaultvalue: '', pattern: this.$9, format: this.$7, mod: 'rw', writeerror: '405' }; this.$1E['cmi.objectives.n.score._children'] = { defaultvalue: '', pattern: this.$9, mod: 'r', writeerror: '402' }; this.$1E['cmi.objectives.n.score.raw'] = { defaultvalue: '', pattern: this.$9, format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.objectives.n.score.min'] = { defaultvalue: '', pattern: this.$9, format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.objectives.n.score.max'] = { defaultvalue: '', pattern: this.$9, format: this.$6, range: this.$19, mod: 'rw', writeerror: '405' }; this.$1E['cmi.objectives.n.status'] = { pattern: this.$9, format: this.$B, mod: 'rw', writeerror: '405' }; this.$1E['cmi.student_data._children'] = { defaultvalue: this.$16, mod: 'r', writeerror: '402' }; this.$1E['cmi.student_data.mastery_score'] = { defaultvalue: (activityTreeNode.getMasteryscore() == null) ? '' : activityTreeNode.getMasteryscore(), mod: 'r', writeerror: '403' }; this.$1E['cmi.student_data.max_time_allowed'] = { defaultvalue: (activityTreeNode.getMaxtimeallowed() == null) ? '' : activityTreeNode.getMaxtimeallowed(), mod: 'r', writeerror: '403' }; this.$1E['cmi.student_data.time_limit_action'] = { defaultvalue: (activityTreeNode.getTimelimitaction() == null) ? 'continue,no message' : activityTreeNode.getTimelimitaction(), mod: 'r', writeerror: '403' }; this.$1E['cmi.student_preference._children'] = { defaultvalue: this.$17, mod: 'r', writeerror: '402' }; this.$1E['cmi.student_preference.audio'] = { defaultvalue: '0', format: this.$5, range: this.$1A, mod: 'rw', writeerror: '405' }; this.$1E['cmi.student_preference.language'] = { defaultvalue: '', format: this.$0, mod: 'rw', writeerror: '405' }; this.$1E['cmi.student_preference.speed'] = { defaultvalue: '0', format: this.$5, range: this.$1B, mod: 'rw', writeerror: '405' }; this.$1E['cmi.student_preference.text'] = { defaultvalue: '0', format: this.$5, range: this.$1D, mod: 'rw', writeerror: '405' }; this.$1E['cmi.interactions._children'] = { defaultvalue: this.$18, mod: 'r', writeerror: '402' }; this.$1E['cmi.interactions._count'] = { defaultvalue: '0', mod: 'r', writeerror: '402' }; this.$1E['cmi.interactions.n.id'] = { defaultvalue: '', pattern: this.$9, format: this.$7, mod: 'w', readerror: 404, writeerror: '405' }; this.$1E['cmi.interactions.n.objectives._count'] = { defaultvalue: '0', pattern: this.$9, mod: 'r', writeerror: '402' }; this.$1E['cmi.interactions.n.objectives.n.id'] = { pattern: this.$9, format: this.$7, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.interactions.n.time'] = { pattern: this.$9, format: this.$2, mod: 'w', readerror: 404, writeerror: '405' }; this.$1E['cmi.interactions.n.type'] = { pattern: this.$9, format: this.$D, mod: 'w', readerror: 404, writeerror: '405' }; this.$1E['cmi.interactions.n.correct_responses._count'] = { defaultvalue: '0', pattern: this.$9, mod: 'r', writeerror: '402' }; this.$1E['cmi.interactions.n.correct_responses.n.pattern'] = { pattern: this.$9, format: this.$8, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.interactions.n.weighting'] = { pattern: this.$9, format: this.$6, range: this.$1C, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.interactions.n.student_response'] = { pattern: this.$9, format: this.$8, mod: 'w', readerror: '404', writeerror: '405' }; this.$1E['cmi.interactions.n.result'] = { pattern: this.$9, format: this.$E, mod: 'w', readerror: 404, writeerror: '405' }; this.$1E['cmi.interactions.n.latency'] = { pattern: this.$9, format: this.$3, mod: 'w', readerror: 404, writeerror: '405' }; this.$1E['nav.event'] = { defaultvalue: '', format: this.$F, mod: 'w', readerror: 404, writeerror: 405 }; var $0 = this.$1F.getDataTree(); if (this.$1F.getDataTreeValue('cmi.core.exit') === 'suspend') { this.$1F.setDataTreeValue('cmi.core.exit', '', false); } else if (!isNullOrUndefined($0) && Object.getKeyCount($0) > 0) { var $1 = $0['cmi.suspend_data']; if (!isNullOrUndefined($1) && ($1['setbysco'])) { $1['setbysco'] = false; } var $dict1 = $0; for (var $key2 in $dict1) { var $2 = { key: $key2, value: $dict1[$key2] }; if (($2.value)['setbysco']) { delete $0[$2.key]; } } } var $dict3 = this.$1E; for (var $key4 in $dict3) { var $3 = { key: $key4, value: $dict3[$key4] }; if ($3.key.match(new RegExp(/\.n\./)) == null) { if (isUndefined(this.$1F.getDataTreeValue($3.key))) { if (!isUndefined((Type.safeCast($3.value, Object))['defaultvalue'])) { this.$1F.setDataTreeValue($3.key, (Type.safeCast($3.value, Object))['defaultvalue'], false); } else { this.$1F.setDataTreeValue($3.key, '', false); } } } } this.$21 = false; this.$22 = false; }
SCORM_1_2.API_LIB.prototype = { $0: null, $1: null, $2: null, $3: null, $4: null, $5: null, $6: null, $7: null, $8: null, $9: null, $A: null, $B: null, $C: null, $D: null, $E: null, $F: null, $10: null, $11: null, $12: null, $13: null, $14: null, $15: null, $16: null, $17: null, $18: null, $19: null, $1A: null, $1B: null, $1C: null, $1D: null, $1E: null, $1F: null, $20: false, $21: false, $22: false, $23: null, $24: 0, getActivityTreeNode: function() { return this.$1F; }, LMSInitialize: function(param) { this.$23 = '0'; this.$22 = false; if (isNullOrUndefined(param)) { param = ''; } if (param === '') { if (!this.$21) { this.$21 = true; this.$23 = '0'; this.$1F.setDataTreeValue('cmi.core.session_time', (this.$1E['cmi.core.session_time'])['defaultvalue'], false); this.$24 = new Date().getTime(); API_BASE.LOG.displayMessage('LMSInitialize with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'true'; } else { this.$23 = '101'; } } else { this.$23 = '201'; } API_BASE.LOG.displayMessage('LMSInitialize with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'false'; }, LMSFinish: function(param) { this.$23 = '0'; if (isNullOrUndefined(param)) { param = ''; } if (param === '') { if (this.$21 && (!this.$22)) { this.$21 = false; this.$22 = true; var $0 = this.$1F.getDataTreeValue('nav.event'); this.$27(true); if (this.$1F.getRoot() != null) { this.$1F.getRoot().onEventSCO(new API_BASE.BaseActivityTreeNodeEventArgs(this.$1F, 0)); if (!isNullOrUndefined($0) && $0.length > 0) { this.$1F.getRoot().requestNavigation($0); } else if (this.$20) { this.$1F.getRoot().requestNavigation('continue'); } } API_BASE.LOG.displayMessage('LMSFinish with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'true'; } else { this.$23 = '301'; } } else { this.$23 = '201'; } API_BASE.LOG.displayMessage('LMSFinish with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'false'; }, LMSGetValue: function(element) { this.$23 = '0'; if (this.$21) { if (isNullOrUndefined(element)) { element = ''; } if (element !== '') { var $0 = new RegExp(this.$9, 'g'); var $1 = element.replace($0, '.n.'); if (!isUndefined(this.$1E[$1])) { if ((Type.safeCast(this.$1E[$1], Object))['mod'] !== 'w') { element = element.replace($0, '$1.'); var $2 = this.$1F.getDataTreeValue(element); if (!isUndefined($2)) { this.$23 = '0'; API_BASE.LOG.displayMessage('LMSGetValue ' + element + ', \'' + $2 + '\'', this.$23, this.$25(this.$23)); return $2; } else { this.$23 = '201'; } } else { this.$23 = (Type.safeCast(this.$1E[$1], Object))['readerror']; } } else { var $3 = '._children'; var $4 = '._count'; if ($1.substr($1.length - $3.length, $1.length) === $3) { var $5 = $1.substr(0, $1.length - $3.length); if (!isUndefined(this.$1E[$5])) { this.$23 = '202'; } else { this.$23 = '201'; } } else if ($1.substr($1.length - $4.length, $1.length) === $4) { var $6 = $1.substr(0, $1.length - $4.length); if (!isUndefined(this.$1E[$6])) { this.$23 = '203'; } else { this.$23 = '201'; } } else { if (element.startsWith('cmi.')) { this.$23 = '201'; } else { this.$23 = '401'; } } } } else { this.$23 = '201'; } } else { this.$23 = '301'; } API_BASE.LOG.displayMessage('LMSGetValue ' + element + ', \'\'', this.$23, this.$25(this.$23)); return ''; }, LMSSetValue: function(element, value) { this.$23 = '0'; if (this.$21) { if (isNullOrUndefined(element)) { element = ''; } if (element !== '') { if (isNullOrUndefined(value)) { value = ''; } var $0 = new RegExp(this.$9, 'g'); var $1 = element.replace($0, '.n.'); if (!isUndefined(this.$1E[$1])) { if ((Type.safeCast(this.$1E[$1], Object))['mod'] !== 'r') { $0 = new RegExp((Type.safeCast(this.$1E[$1], Object))['format']); value = value + ''; var $2 = value.match($0); if ($2 != null) { if (element !== $1) { var $3 = element.split('.'); var $4 = 'cmi'; for (var $5 = 1; $5 < $3.length - 1; $5++) { var $6 = $3[$5]; var $7 = $3[$5 + 1].match(new RegExp(/^\d+$/)); if ($7 != null && $7.length > 0) { var $8 = false; if (isUndefined(this.$1F.getDataTreeValue($4 + '.' + $6 + '._count'))) { this.$1F.setDataTreeValue($4 + '.' + $6 + '._count', '0', false); $8 = true; } else if (parseInt($3[$5 + 1]) === parseInt(this.$1F.getDataTreeValue($4 + '.' + $6 + '._count'))) { if ($5 + 3 < $3.length && $3[$5 + 2] === 'objectives') { $7 = $3[$5 + 3].match(new RegExp(/^\d+$/)); if ($7 != null && $7.length > 0 && parseInt($3[$5 + 3]) !== 0) { this.$23 = '201'; return 'false'; } } this.$1F.setDataTreeValue($4 + '.' + $6 + '._count', (parseInt(this.$1F.getDataTreeValue($4 + '.' + $6 + '._count')) + 1).toString(), false); $8 = true; } else if (parseInt($3[$5 + 1]) > parseInt(this.$1F.getDataTreeValue($4 + '.' + $6 + '._count'))) { this.$23 = '201'; return 'false'; } $4 = $4 + '.' + $6 + $3[$5 + 1]; if ($8) { if ($4.substr(0, 14) === 'cmi.objectives') { this.$1F.setDataTreeValue($4 + '.score._children', this.$12, false); this.$1F.setDataTreeValue($4 + '.score.raw', '', false); this.$1F.setDataTreeValue($4 + '.score.min', '', false); this.$1F.setDataTreeValue($4 + '.score.max', '', false); this.$1F.setDataTreeValue($4 + '.status', 'not attempted', false); } else if ($4.substr(0, 16) === 'cmi.interactions') { this.$1F.setDataTreeValue($4 + '.objectives._count', '0', false); this.$1F.setDataTreeValue($4 + '.correct_responses._count', '0', false); } } $5++; } else { $4 = $4 + '.' + $6; } } element = $4 + '.' + $3[$3.length - 1]; } if (this.$23 === '0') { if (!isUndefined((Type.safeCast(this.$1E[$1], Object))['range'])) { var $9 = (Type.safeCast(this.$1E[$1], Object))['range']; var $A = $9.split('#'); if (!isNaN(this.$26(value))) { value = (parseFloat(value) * 1).toString(); if ((parseFloat(value) >= parseFloat($A[0])) && (parseFloat(value) <= parseFloat($A[1]))) { this.$1F.setDataTreeValue(element, value, true); this.$23 = '0'; API_BASE.LOG.displayMessage('LMSSetValue ' + element + ', \'' + value + '\'', this.$23, this.$25(this.$23)); return 'true'; } else { this.$23 = (Type.safeCast(this.$1E[$1], Object))['writeerror']; } } else { this.$23 = (Type.safeCast(this.$1E[$1], Object))['writeerror']; } } else { if (element === 'cmi.comments') { this.$1F.setDataTreeValue('cmi.comments', this.$1F.getDataTreeValue('cmi.comments') + value, true); } else { this.$1F.setDataTreeValue(element, value, true); } this.$23 = '0'; API_BASE.LOG.displayMessage('LMSSetValue ' + element + ', \'' + value + '\'', this.$23, this.$25(this.$23)); return 'true'; } } } else { this.$23 = (Type.safeCast(this.$1E[$1], Object))['writeerror']; } } else { this.$23 = (Type.safeCast(this.$1E[$1], Object))['writeerror']; } } else { if (element.startsWith('cmi.')) { this.$23 = '201'; } else { this.$23 = '401'; } } } else { this.$23 = '201'; } } else { this.$23 = '301'; return ''; } API_BASE.LOG.displayMessage('LMSSetValue ' + element + ', \'' + value + '\'', this.$23, this.$25(this.$23)); return 'false'; }, LMSCommit: function(param) { this.$23 = '0'; if (isNullOrUndefined(param)) { param = ''; } if (param === '') { if (this.$21) { this.$27(false); API_BASE.LOG.displayMessage('LMSCommit with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'true'; } else { this.$23 = '301'; } } else { this.$23 = '201'; } API_BASE.LOG.displayMessage('LMSCommit with param: \'' + param + '\'', this.$23, this.$25(this.$23)); return 'false'; }, LMSGetLastError: function() { API_BASE.LOG.displayMessage('LMSGetLastError, Error Code: ' + this.$23, '0', null); return this.$23; }, LMSGetErrorString: function(param) { if (isNullOrUndefined(param)) { param = ''; } if (param !== '') { var $0 = this.$25(param); if (!isNullOrUndefined($0)) { API_BASE.LOG.displayMessage('LMSGetErrorString with param: \'' + param + '\', Error String: ' + $0, '0', null); return $0; } } API_BASE.LOG.displayMessage('LMSGetErrorString with param: \'' + param + '\', No error string found!', '0', null); return ''; }, $25: function($p0) { var $0 = {}; $0['0'] = 'No error'; $0['101'] = 'General exception'; $0['201'] = 'Invalid argument error'; $0['202'] = 'Element cannot have children'; $0['203'] = 'Element not an array - cannot have count'; $0['301'] = 'Not initialized'; $0['401'] = 'Not implemented error'; $0['402'] = 'Invalid set value, element is a keyword'; $0['403'] = 'Element is read only'; $0['404'] = 'Element is write only'; $0['405'] = 'Incorrect Data Type'; if (!isUndefined($0[$p0])) { return $0[$p0]; } else { return null; } }, LMSGetDiagnostic: function(param) { if (isNullOrUndefined(param)) { param = ''; } if (param === '') { param = this.$23; } API_BASE.LOG.displayMessage('LMSGetDiagnostic with param: \'' + param + '\'', '0', null); return this.LMSGetErrorString(param); }, $26: function($p0) { return $p0; }, $27: function($p0) { var $0 = false; if ($p0) { if (this.$1F.getDataTreeValue('cmi.core.exit') === 'suspend') { $0 = true; this.$1F.setDataTreeValue('cmi.core.entry', 'resume', false); } else { this.$1F.setDataTreeValue('cmi.core.entry', '', false); } if (this.$1F.getDataTreeValue('cmi.core.lesson_status') === 'not attempted') { if (this.$1F.getDataTreeValue('cmi.core.lesson_mode') === 'browse') { this.$1F.setDataTreeValue('cmi.core.lesson_status', 'browsed', false); } else { this.$1F.setDataTreeValue('cmi.core.lesson_status', 'completed', false); } } if (this.$1F.getDataTreeValue('cmi.core.lesson_mode') === 'normal') { if (this.$1F.getDataTreeValue('cmi.core.credit') === 'credit') { if (this.$1F.getDataTreeValue('cmi.core.lesson_status') === 'completed') { if (this.$1F.getDataTreeValue('cmi.student_data.mastery_score') !== '' && this.$1F.getDataTreeValue('cmi.core.score.raw') !== '') { if (parseFloat(this.$1F.getDataTreeValue('cmi.core.score.raw')) >= parseFloat(this.$1F.getDataTreeValue('cmi.student_data.mastery_score'))) { this.$1F.setDataTreeValue('cmi.core.lesson_status', 'passed', false); } else { this.$1F.setDataTreeValue('cmi.core.lesson_status', 'failed', false); } } } } } if (this.$1F.getDataTreeValue('cmi.core.session_time') === (this.$1E['cmi.core.session_time'])['defaultvalue']) { this.$1F.setDataTreeValue('cmi.core.session_time', this.$28((new Date().getTime() - this.$24) / 1000), false); } if (this.$1F.getDataTreeValue('cmi.core.session_time') != null && this.$1F.getDataTreeValue('cmi.core.session_time') !== '') { this.$1F.setDataTreeValue('cmi.core.total_time', this.$29(this.$1F.getDataTreeValue('cmi.core.total_time'), this.$1F.getDataTreeValue('cmi.core.session_time')), false); } } if (!$0 && this.$1F.getLessonstatus() !== this.$1F.getDataTreeValue('cmi.core.lesson_status')) { this.$1F.setLessonstatus(this.$1F.getDataTreeValue('cmi.core.lesson_status')); if (this.$1F.getRoot() != null) { this.$1F.getRoot().reEvaluate(); } } if (this.$1F.getRoot() != null) { this.$1F.getRoot().onEventSCO(new API_BASE.BaseActivityTreeNodeEventArgs(this.$1F, 1)); } }, $28: function($p0) { var $0 = $p0 - Math.floor($p0 / 60) * 60; $p0 -= $0; var $1 = $p0 - Math.floor($p0 / 3600) * 3600; $p0 -= $1; $0 = Math.round($0 * 100) / 100; var $2 = $0.toString(); var $3 = $2; var $4 = ''; if ($2.indexOf('.') !== -1) { $3 = $2.substring(0, $2.indexOf('.')); $4 = $2.substring($2.indexOf('.') + 1, $2.length); } if ($3.length < 2) { $3 = '0' + $3; } $2 = $3; if ($4.length > 0) { $2 = $2 + '.' + $4; } var $5; if ($p0 - Math.floor($p0 / 3600) * 3600 !== 0) { $5 = 0; } else { $5 = ($p0 / 3600); } var $6; if ($1 - Math.floor($1 / 60) * 60 !== 0) { $6 = 0; } else { $6 = ($1 / 60); } var $7 = $5.toString(); if ($7.length < 2) { $7 = '0' + $7; } var $8 = $6.toString(); if ($8.length < 2) { $8 = '0' + $8; } return $7 + ':' + $8 + ':' + $2; }, $29: function($p0, $p1) { var $0 = $p0.split(':'); var $1 = $p1.split(':'); var $2 = $0[2].split('.'); var $3 = $1[2].split('.'); var $4 = 0; var $5 = 0; if ($2.length > 1) { $5 = parseInt($2[1], 10); } var $6 = 0; if ($3.length > 1) { $6 = parseInt($3[1], 10); } var $7 = $5 + $6; $4 = Math.floor($7 / 100); $7 = $7 - ($4 * 100); var $8 = $7.toString(); if (Math.floor($7) < 10) { $8 = '0' + $7.toString(); } var $9 = parseInt($2[0], 10) + parseInt($3[0], 10) + $4; $4 = Math.floor($9 / 60); $9 = $9 - ($4 * 60); var $A = $9.toString(); if (Math.floor($9) < 10) { $A = '0' + $9.toString(); } var $B = parseInt($0[1], 10) + parseInt($1[1], 10) + $4; $4 = Math.floor($B / 60); $B = $B - ($4 * 60); var $C = $B.toString(); if ($B < 10) { $C = '0' + $B.toString(); } var $D = parseInt($0[0], 10) + parseInt($1[0], 10) + $4; var $E = $D.toString(); if ($D < 10) { $E = '0' + $D.toString(); } if ($7 !== 0) { return $E + ':' + $C + ':' + $A + '.' + $8; } else { return $E + ':' + $C + ':' + $A; } }, isFinishAttempted: function() { return this.$22; }, isInitAttempted: function() { return this.$21; } }
API = function() { }
API.setAPI_LIB = function(api_lib) { API.$0 = api_lib; }
API.LMSInitialize = function(param) {
	setupTrackingVars();
	return API.$0.LMSInitialize(param);
}
API.LMSFinish = function(param) {
    //closeLearning();
    if (vtype === "diag" && attempted === true) {
        var jstring = JSON.stringify(objson);
        var data = { action: "StoreDiagnosticJson", ProgressID: vprog, DiagnosticOutcome: jstring }
        $.ajax({
            type: "GET",
            url: trackurl,
            data: data,
            success: saveSuccess(data),
            dataType: String
        });
    }
    if (vtype === "pl" && s >= 1) {
        var data = { action: "StoreASPAssessNoSession", CandidateID: vcandidate, CustomisationID: vcust, Version: vversion, SectionID: vsection, Score: s }
        $.ajax({
            type: "GET",
            url: trackurl,
            data: data,
            dataType: String
        });
	}
	setTimeout(function () { window.parent.closeMpe(); }, 1000);
	return API.$0.LMSFinish(param);
}

API.LMSGetValue = function (element) { return DLSGetValue(element); }
API.LMSSetValue = function (element, value) {
    ITSPSetValue(element, value);
    return API.$0.LMSSetValue(element, value);
};
API.LMSCommit = function (param) {

    return API.$0.LMSCommit(param);
};
API.LMSGetLastError = function () { return API.$0.LMSGetLastError(); };
API.LMSGetErrorString = function (param) { return API.$0.LMSGetErrorString(param); };
API.LMSGetDiagnostic = function () { return false; };
SCORM_1_2.ActivityTreeNode.createClass('SCORM_1_2.ActivityTreeNode', null, API_BASE.IActivityTreeNode); SCORM_1_2.ActivityTree.createClass('SCORM_1_2.ActivityTree', SCORM_1_2.ActivityTreeNode, API_BASE.IActivityTree); SCORM_1_2.API_LIB.createClass('SCORM_1_2.API_LIB', null, API_BASE.IAPI); API.createClass('API'); SCORM_1_2.API_LIB.defaulT_LESSON_STATUS = 'not attempted'; API.$0 = null;

//Variable to hold time:

//Variable to hold score:
var startDate = new Date().getTime();
var s;
var vsection;
var vversion;
var vcandidate;
var vtutorialid;
var vcust;
var trackurl;
var vprog;
var vtype;
var accumulatedTime;
var fixedtime = "0";
var objson;
var interactionid;
var attempted = false;
var assessmentsubmitted = false;

function setupTrackingVars() {
	trackurl = document.getElementById('hftrackurl').value;
	vsection = document.getElementById('hfsection').value;
	vversion = document.getElementById('hfversion').value;
	vcandidate = document.getElementById('hfcandidate').value;
	vtutorialid = document.getElementById('hfTutorialId').value;
	vprog = document.getElementById('hfprog').value;
	vcust = document.getElementById('hfcustomisation').value;
	vtype = document.getElementById('hfContentType').value;
	if (vtype != "learn") {
		var data = { action: "GetObjectiveArray", CustomisationID: vcust, SectionID: vsection }
		$.ajax({
			type: "GET",
			url: trackurl,
			data: data,
			success: setUpObjectiveArray,
			error: function(jqxhr, stat, err) {
				alert(jqxhr + '     ' + stat);
			}
		});	
	}
}
function StoredSuccess(v)
{
	if (v !== "") {
		window.parent.closeMpe();
    }
}
function ITSPSetValue(e, v) {
//	if (e === "cmi.core.session_time") {

//		var rawtime = v;
//		accumulatedTime = accumulatedTime + rawtime;
//		fixedtime = parseInt(fixedtime) + parseInt(rawtime.substring(5, 7));
	//	}
	var earr = e.split(".");
	if (earr[1] === "interactions" && earr[3] === "result") {
		attempted = true;
		if (v != "wrong") {
			interactionid = earr[2]
			$.each(objson, function(i, item) {
				var intarray = item["interactions"];
				if ($.inArray(parseInt(interactionid), intarray) >= 0 || interactionid.toString() === intarray.toString()) {
					objson[i]["myscore"] = objson[i]["myscore"] + 1;
				}
			});
		}
	}
	if (e === "cmi.core.score.raw") {
	    s = v;
	    
	}
    if (e === "cmi.core.exit") {
       
		if (vtype === "diag" && attempted === true) {
	        var jstring = JSON.stringify(objson);
	        var data = { action: "StoreDiagnosticJson", ProgressID: vprog, DiagnosticOutcome: jstring }
	        $.ajax({
	            type: "GET",
	            url: trackurl,
	            data: data,
	            success: saveSuccess(data),
	            dataType: String
	        });
	    }
	    if (vtype === "pl" && s >= 1) {
	        var data = { action: "StoreASPAssessNoSession", CandidateID: vcandidate, CustomisationID: vcust, Version: vversion, SectionID: vsection, Score: s }
	        $.ajax({
	            type: "GET",
	            url: trackurl,
	            data: data,
				success: StoredSuccess(v),
	            dataType: String
	        });
        }
		else if (vtype !== "pl" && v === "") {
            //Store complete
            window.parent.closeMpe();
        }
    }
	if (e === "cmi.core.lesson_status") {
		var stat;
		if (startDate != 0) {
			var currentDate = new Date().getTime();
			fixedtime = ((currentDate - startDate) / 60000);
		}
		if (v === "passed" | v === "completed" | v === "complete") {

			//Store complete
		    stat = "2";

		}
		else {
		    //Store "started" 
		    stat = "1";
		}
	    //Store  to ITSP tracking:
		if (vtutorialid == null | vtutorialid == '0') {
			var data = { action: "StoreASPProgressNoSession", TutorialStatus: stat, TutorialTime: fixedtime, ProgressID: vprog, CandidateID: vcandidate, Version: vversion, CustomisationID: vcust }
		}
		else
		{
			var data = { action: "StoreASPProgressV2", TutorialStatus: stat, TutorialTime: fixedtime, ProgressID: vprog, CandidateID: vcandidate, Version: vversion, CustomisationID: vcust, TutorialID: vtutorialid }
        }
		$.ajax({
			type: "GET",
			url: trackurl,
			data: data,
			success: saveSuccess(data),
			dataType: String
		});
	}
	if (e === "cmi.suspend_data") {
		if (v.length > 0) {
			var data = {
				action: "StoreSuspendData",
				progressId: vprog,
				TutorialID: vtutorialid,
				CustomisationID: vcust,
				CandidateID: vcandidate,
				suspendData: v
			}
			$.ajax({
				type: "GET",
				url: trackurl,
				data: data,
				dataType: String
			});
		}
	}
	if (e === "cmi.core.lesson_location") {
		if (v.length > 0) {
			var data = {
				action: "StoreLessonLocation",
				progressId: vprog,
				TutorialID: vtutorialid,
				CustomisationID: vcust,
				CandidateID: vcandidate,
				lessonLocation: v
			}
			$.ajax({
				type: "GET",
				url: trackurl,
				data: data,
				dataType: String
			});
		}
	}
}
function DLSGetValue(e) {
	if (e === "cmi.suspend_data") {
		var r = document.getElementById('hfSuspendData').value;
		return r || '';
	}
	else if (e === "cmi.core.lesson_location") {
		var r = document.getElementById('hfLessonLocation').value;
		return r || '';
	}
	else {
		var r = API.$0.LMSGetValue(e);
		return r; 
	};
}

function saveSuccess(d) {
	//alert('erm');
}

function setUpObjectiveArray(data, textStatus, jqXHR) {
	objson = data["objectives"];
}
var getUrlParameter = function getUrlParameter(sParam) {
	var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

	for (i = 0; i < sURLVariables.length; i++) {
		sParameterName = sURLVariables[i].split('=');

		if (sParameterName[0] === sParam) {
			return sParameterName[1] === undefined ? true : sParameterName[1];
		}
	}
};