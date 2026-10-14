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

## 🖱️ 1. أداة التحكم بالماوس والكيبورد المدمجة في السكيل (AI Desktop Hands Driver)

تم تزويد السكيل بمحرك تشغيل ذاتي مستقل يقع في:  
📁 `C:\Users\Yasin1\.gemini\config\skills\roblox-hyper-realism\scripts\autonomous_pc_driver.py`

يستطيع أي ذكاء اصطناعي استدعاء هذه الأوامر عبر أي Terminal أو Process ليتحكم بالحاسوب مباشرة وبشكل مرئي:

### جدول الأوامر المتاحة للـ AI:

| الأمر الذي يشغله الـ AI | ماذا يحدث أمام عين المستخدم على الشاشة؟ |
| :--- | :--- |
| `python ".../autonomous_pc_driver.py" open_app "Roblox Studio"` | يضغط زر Start، يكتب اسم التطبيق، ويفتحه بالماوس والكيبورد تلقائياً. |
| `python ".../autonomous_pc_driver.py" focus_studio` | يجد نافذة Roblox Studio، ويعيد تكبيرها ويجلبها إلى مقدمة الشاشة. |
| `python ".../autonomous_pc_driver.py" move_mouse 960 540` | يتحرك مؤشر الماوس بسلاسة ملحوظة أمام المستخدم إلى منتصف الشاشة. |
| `python ".../autonomous_pc_driver.py" click 500 300` | يتحرك الماوس إلى الإحداثيات وينقر الزر الأيسر بشكل مرئي ومؤكد. |
| `python ".../autonomous_pc_driver.py" inject_command_bar "<path_to_lua>"` | **السحر الحقيقي**: يركز على استوديو، يفتح شريط الأوامر، يلصق الكود، ويضغط Enter لتطبيق الجرافيكس والأسلحة فوراً! |
| `python ".../autonomous_pc_driver.py" play` | يحرك الماوس ويضغط زر التجربة F5 لتشغيل الماب واختبار الشخصية والأسلحة. |
| `python ".../autonomous_pc_driver.py" screenshot "view.png"` | يلتقط صورة للشاشة لتمكين الـ AI من رؤية النتيجة وتحليل المشهد بصرياً. |

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
