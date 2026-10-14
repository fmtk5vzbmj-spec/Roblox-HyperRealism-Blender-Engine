---
name: roblox-hyper-realism
description: >
  السكيل الذكي المخصص لعملاء الذكاء الاصطناعي (AI Autonomous Agents) لتحويل أي مشروع أو ماب في روبلوكس
  إلى واقعية AAA تضاهي Blender و Unreal Engine 5 بشكل ذاتي وتلقائي بالكامل.
  يوفر بروتوكول تحكم آلي، ونظام فحص ذاتي (Self-Diagnostics)، ومحرك رئيسي موحد (Unified AI API)،
  ومعالجة أوتوماتيكية للأسلحة والـ IK والجرافيكس وخامات الـ PBR بضغطة زر أو أمر كود واحد.
user-invocable: true
---

# 🤖 دليل تشغيل الذكاء الاصطناعي للواقعية الفائقة (AI Autonomous Agent Protocol 4.0)

هذا الدليل مجهز خصيصاً لتمكين **أي عميل ذكاء اصطناعي (AI Agent / Antigravity / Subagent)** - حتى لو لم تكن لديه أدوات مدمجة للتحكم بالماوس والشاشة - من امتلاك **أيدٍ وعيون رقمية حقيقية (Autonomous Hands & Vision)** للتحكم بالكمبيوتر، وفتح التطبيقات، وتحريك الماوس أمام عين المستخدم، والتفاعل المباشر مع واجهة **Roblox Studio**.

---

## 👁️ 1. محرك العيون الحية والبث اللحظي في الرام (Live AI Eyes & Streaming Vision)

بدلاً من أخذ لقطات شاشة بطيئة (Screenshots) وحفظها على الهاردسك، يعتمد السكيل الآن على **محرك رؤية حي ومستمر (Continuous In-Memory Stream)**:
- التقاط إطارات الشاشة بسرعة تصل إلى **30-60 FPS** مباشرة في الذاكرة العشوائية (RAM) عبر `mss` و `numpy` بدون كتابة أي بايت على الديسك.
- متابعة حركة المستخدم وموضع الماوس والنوافذ النشطة لحظة بلحظة (Optical Motion & Activity Tracking).
- واجهة استشعار فورية `live_status` تسمح للذكاء الاصطناعي بمعرفة ما تفعله على الشاشة وكأنه "جالس بجانبك يتابعك حياً بعيون رقمية".

📁 مسار المحرك: `scripts/live_ai_eyes.py` و `scripts/autonomous_pc_driver.py`

### جدول الأوامر الحية المتاحة للـ AI:

| الأمر الذي يشغله الـ AI | سلوك الرؤية الحية أمام المستخدم |
| :--- | :--- |
| `python ".../autonomous_pc_driver.py" live_eyes` | تفعيل البث الحي مع مؤشر عائم صغير (Floating Cyber HUD) في زاوية الشاشة يوضح أن الـ AI يتابعك حياً. |
| `python ".../autonomous_pc_driver.py" live_status` | فحص فوري ومستمر في الرام لحالة النافذة وموقع الماوس وتفاعل الشاشة بدون سكرين شوت. |
| `python ".../autonomous_pc_driver.py" open_app "Roblox Studio"` | يفتح التطبيق بالماوس والكيبورد تلقائياً أمامك. |
| `python ".../autonomous_pc_driver.py" focus_studio` | يركز على استوديو ويجلبه للأمام فوراً. |
| `python ".../autonomous_pc_driver.py" inject_command_bar "<path>"` | يلصق الكود في Command Bar ويضغط Enter أمامك لتطبيق الجرافيكس والأسلحة. |
| `python ".../autonomous_pc_driver.py" play` | يحرك الماوس ويضغط زر F5 لاختبار الماب والفيزياء. |

---

## 🎯 2. شجرة اتخاذ القرار الآلي (AI Decision Matrix)

عندما يطلب المستخدم منك أي ميزة واقعية، اتبع هذا المسار المنطقي:

```
                       [استلام طلب المستخدم]
                                 │
             ┌───────────────────┴───────────────────┐
             ▼                                       ▼
       [ماب / جرافيكس / خامات]                 [أسلحة / فيزياء / حركة]
             │                                       │
             ├─ 1. تفعيل Future Lighting             ├─ 1. حقن HyperRealisticWeaponsEngine
             ├─ 2. حقن Atmosphere & Bloom           ├─ 2. تفعيل Spring Recoil & Ballistics
             ├─ 3. تسجيل خامات PBR 2K/4K             ├─ 3. ربط ProceduralFullBodyIK (Q/E + Foot)
             └─ 4. تشغيل نحت 3D التضاريس             └─ 4. تفعيل Wallbang & Supersonic Crack
                                 │
                                 ▼
         [التنفيذ المباشر أمام المستخدم بالماوس]
         - تشغيل: python autonomous_pc_driver.py inject_command_bar
         - التركيز التلقائي على Roblox Studio
         - فحص النتيجة وتشغيل وضع اللعب بالماوس
```

---

## ⚡ 3. واجهة الذكاء الاصطناعي الموحدة (Unified AI Master API)

للتحكم البرمجي الكامل، تم توفير الملف:  
📄 [`HyperRealismMasterAI.luau`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/HyperRealismMasterAI.luau)

يسمح للذكاء الاصطناعي بتنفيذ الإعدادات المناسبة بطلب واحد فقط:

```lua
local MasterAI = require(workspace.HyperRealismMasterAI)

MasterAI.Deploy({
    Biome = "AlpineForest",             -- "AlpineForest" | "NordicFjord" | "DesertCanyon" | "NightOpsRain"
    LightingPreset = "CinematicGolden", -- "CinematicGolden" | "OvercastMisty" | "NightTactical"
    CombatSuite = {
        EnableBallistics = true,
        EnableWallbang = true,
        EnableShellEjection = true,
        MuzzleVelocity = 880,
    },
    CharacterSuite = {
        TrueFirstPerson = true,
        TacticalLeaning = true,
        IKFootPlanting = true,
    }
})
```

---

## 🩺 4. نظام الفحص الذاتي والتصحيح التلقائي (Self-Diagnostics & Auto-Healing)

يجب على الـ AI تشغيل دالة `MasterAI.RunDiagnostics()` للتأكد من الآتي:

1. **فحص الإضاءة (Lighting Technology Check)**: تحويلها تلقائياً إلى `Enum.Technology.Future`.
2. **فحص الـ MaterialService**: تفعيل `Use2022Materials = true` لتشغيل خرائط الـ PBR والـ Normal.
3. **تنظيف المؤثرات المكررة**: مسح كائنات `Atmosphere` أو `Bloom` الفائضة لتفادي تدهور الصورة.
4. **حفظ 60 FPS**: استدعاء `Debris:AddItem()` لتنظيف فوارغ الرصاص والشرار تلقائياً.
