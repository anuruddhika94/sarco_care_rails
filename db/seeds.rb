# Recreates the demo data implied by the Flutter app's mocks (see
# sarco_care/lib/l10n/app_en.arb and lib/data/meal_plan.dart) so the backend
# is immediately usable against the real app. Idempotent — safe to re-run.

puts "Seeding users..."

somchai = User.find_or_create_by!(phone_number: "081 234 5678") do |u|
  u.full_name = "Somchai Jai-Dee"
  u.email = "somchai@example.com"
  u.password = "password123"
  u.role = :patient
  u.date_of_birth = 72.years.ago.to_date
  u.gender = :male
end

wanida = User.find_or_create_by!(phone_number: "081 111 2222") do |u|
  u.full_name = "Wanida Suksawat"
  u.password = "password123"
  u.role = :patient
  u.date_of_birth = 68.years.ago.to_date
  u.gender = :female
end

prasert = User.find_or_create_by!(phone_number: "081 333 4444") do |u|
  u.full_name = "Prasert Chaiyo"
  u.password = "password123"
  u.role = :patient
  u.date_of_birth = 75.years.ago.to_date
  u.gender = :male
end

malee = User.find_or_create_by!(phone_number: "089 876 5432") do |u|
  u.full_name = "Malee Jai-Dee"
  u.password = "password123"
  u.role = :caretaker
end

puts "Seeding care links..."

{ somchai => "Daughter", wanida => "Daughter", prasert => "Daughter" }.each do |patient, relationship|
  CareLink.find_or_create_by!(patient: patient, caretaker: malee) do |link|
    link.relationship = relationship
    link.status = :approved
  end
end

puts "Seeding the 3-day meal plan..."

meal_plan_data = [
  {
    day_number: 1, label_en: "Day 1", label_th: "วันที่ 1",
    day_total_en: "~50 g/day", day_total_th: "~50 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Minced pork congee + ½ boiled egg", title_th: "ข้าวต้มหมูสับ + ไข่ต้ม ½ ฟอง",
        icon: "rice_bowl", total_protein_en: "~13 g", total_protein_th: "~13 กรัม", image: "assets/images/meals/plan_d1_breakfast.jpg",
        items: [
          { name_en: "Rice congee · 1 small bowl", name_th: "ข้าวต้ม 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Lean minced pork · 40 g", name_th: "หมูสับไม่ติดมัน 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] },
      { slot: :lunch, title_en: "Tofu & pork clear soup + soft rice", title_th: "แกงจืดเต้าหู้หมูสับ + ข้าวสวยนุ่ม",
        icon: "soup_kitchen", total_protein_en: "~14 g", total_protein_th: "~14 กรัม", image: "assets/images/meals/plan_d1_lunch.jpg",
        items: [
          { name_en: "Soft tofu · ½ tube", name_th: "เต้าหู้อ่อน ½ หลอด", protein_en: "~4 g", protein_th: "~4 กรัม" },
          { name_en: "Lean minced pork · 40 g", name_th: "หมูสับไม่ติดมัน 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Rice · ½–¾ bowl", name_th: "ข้าวสวย ½–¾ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Steamed lime fish + boiled veg + rice", title_th: "ปลานึ่งมะนาว + ผักต้ม + ข้าวสวย",
        icon: "set_meal", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d1_dinner.jpg",
        items: [
          { name_en: "Fish · 60 g", name_th: "เนื้อปลา 60 กรัม", protein_en: "~13 g", protein_th: "~13 กรัม" },
          { name_en: "Boiled vegetables · 1 cup", name_th: "ผักต้ม 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :before_bed, title_en: "Plain milk · 1 small glass (200 ml)", title_th: "นมจืด 1 แก้วเล็ก (200 มล.)",
        icon: "local_drink_outlined", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Plain milk · 200 ml", name_th: "นมจืด 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 2, label_en: "Day 2", label_th: "วันที่ 2",
    day_total_en: "~50–52 g/day", day_total_th: "~50–52 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Fish congee + ½ boiled egg", title_th: "โจ๊กปลา + ไข่ต้ม ½ ฟอง",
        icon: "rice_bowl", total_protein_en: "~14 g", total_protein_th: "~14 กรัม", image: "assets/images/meals/plan_d2_breakfast.jpg",
        items: [
          { name_en: "Fish · 40 g", name_th: "เนื้อปลา 40 กรัม", protein_en: "~9 g", protein_th: "~9 กรัม" },
          { name_en: "Rice porridge · 1 small bowl", name_th: "ข้าวโจ๊ก 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + ginger chicken + tofu", title_th: "ข้าว + ไก่ผัดขิง + เต้าหู้",
        icon: "ramen_dining", total_protein_en: "~15–17 g", total_protein_th: "~15–17 กรัม", image: "assets/images/meals/plan_d2_lunch.jpg",
        items: [
          { name_en: "Skinless chicken breast · 50 g", name_th: "อกไก่ไม่ติดหนัง 50 กรัม", protein_en: "~11 g", protein_th: "~11 กรัม" },
          { name_en: "Soft tofu · ⅓–½ tube", name_th: "เต้าหู้อ่อน ⅓–½ หลอด", protein_en: "~2–4 g", protein_th: "~2–4 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Egg, tofu & pork clear soup + rice", title_th: "แกงจืดไข่น้ำเต้าหู้หมูสับ + ข้าวสวย",
        icon: "soup_kitchen", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d2_dinner.jpg",
        items: [
          { name_en: "Egg · 1", name_th: "ไข่ 1 ฟอง", protein_en: "~6 g", protein_th: "~6 กรัม" },
          { name_en: "Lean minced pork · 30 g", name_th: "หมูสับไม่ติดมัน 30 กรัม", protein_en: "~6 g", protein_th: "~6 กรัม" },
          { name_en: "Tofu · ½ tube", name_th: "เต้าหู้ ½ หลอด", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :snack, title_en: "Plain yogurt · 1 small cup", title_th: "โยเกิร์ตรสธรรมชาติ 1 ถ้วยเล็ก",
        icon: "icecream", total_protein_en: "~4–5 g", total_protein_th: "~4–5 กรัม", image: nil,
        items: [
          { name_en: "Plain yogurt · 1 small cup", name_th: "โยเกิร์ตรสธรรมชาติ 1 ถ้วยเล็ก", protein_en: "~4–5 g", protein_th: "~4–5 กรัม" }
        ] }
    ]
  },
  {
    day_number: 3, label_en: "Day 3", label_th: "วันที่ 3",
    day_total_en: "~50–53 g/day", day_total_th: "~50–53 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Fish congee + boiled egg + spinach", title_th: "ข้าวต้มปลา + ไข่ต้ม + ผักโขม",
        icon: "rice_bowl", total_protein_en: "~15 g", total_protein_th: "~15 กรัม", image: "assets/images/meals/plan_d3_breakfast.jpg",
        items: [
          { name_en: "Fish · 40 g", name_th: "เนื้อปลา 40 กรัม", protein_en: "~9 g", protein_th: "~9 กรัม" },
          { name_en: "Rice congee · 1 small bowl", name_th: "ข้าวต้ม 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" },
          { name_en: "Spinach · ½ cup", name_th: "ผักโขม ½ ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" }
        ] },
      { slot: :lunch, title_en: "Steamed egg with shrimp + veg + rice", title_th: "ไข่ตุ๋นกุ้ง + ผักลวก + ข้าวสวย",
        icon: "egg_alt", total_protein_en: "~15–17 g", total_protein_th: "~15–17 กรัม", image: "assets/images/meals/plan_d3_lunch.jpg",
        items: [
          { name_en: "Egg · 1", name_th: "ไข่ 1 ฟอง", protein_en: "~6 g", protein_th: "~6 กรัม" },
          { name_en: "Minced shrimp · 40 g", name_th: "กุ้งสับ 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Blanched vegetables · 1 cup", name_th: "ผักลวก 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Grilled/steamed fish + veg soup + rice", title_th: "ปลาย่าง/นึ่ง + ซุปผัก + ข้าวสวย",
        icon: "set_meal", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d3_dinner.jpg",
        items: [
          { name_en: "Fish · 60 g", name_th: "เนื้อปลา 60 กรัม", protein_en: "~13 g", protein_th: "~13 กรัม" },
          { name_en: "Vegetables · 1 cup", name_th: "ผักต้ม 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :snack, title_en: "Plain milk (200 ml) + ½ boiled egg", title_th: "นมจืด 1 แก้วเล็ก (200 มล.) + ไข่ต้ม ½ ฟอง",
        icon: "local_drink_outlined", total_protein_en: "~10 g", total_protein_th: "~10 กรัม", image: nil,
        items: [
          { name_en: "Plain milk · 200 ml", name_th: "นมจืด 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] }
    ]
  }
]

meal_plan_data.each do |day_data|
  day = MealPlanDay.find_or_create_by!(day_number: day_data[:day_number]) do |d|
    d.label_en = day_data[:label_en]
    d.label_th = day_data[:label_th]
    d.day_total_en = day_data[:day_total_en]
    d.day_total_th = day_data[:day_total_th]
  end

  day_data[:meals].each_with_index do |meal_data, meal_position|
    meal = MealPlanMeal.find_or_create_by!(meal_plan_day: day, slot: meal_data[:slot]) do |m|
      m.title_en = meal_data[:title_en]
      m.title_th = meal_data[:title_th]
      m.icon = meal_data[:icon]
      m.total_protein_en = meal_data[:total_protein_en]
      m.total_protein_th = meal_data[:total_protein_th]
      m.image = meal_data[:image]
      m.position = meal_position
    end

    meal_data[:items].each_with_index do |item_data, item_position|
      MealPlanItem.find_or_create_by!(meal_plan_meal: meal, name_en: item_data[:name_en]) do |i|
        i.name_th = item_data[:name_th]
        i.protein_en = item_data[:protein_en]
        i.protein_th = item_data[:protein_th]
        i.position = item_position
      end
    end
  end
end

puts "Seeding exercises..."

exercises_data = [
  { key: "seated_leg_lift", name_en: "Seated Leg Lift", name_th: "ยกขาท่านั่ง", video_id: "BoA431kaU2M",
    icon: "airline_seat_recline_normal", default_minutes: 10, day_number: 1 },
  { key: "arm_curls", name_en: "Arm Curls", name_th: "งอแขนยกน้ำหนัก", video_id: "eZhhNN4QkSk",
    icon: "fitness_center", default_minutes: 8, day_number: 2 },
  { key: "chair_squats", name_en: "Chair Squats", name_th: "สควอทกับเก้าอี้", video_id: "7QZKb9E5dbg",
    icon: "chair_alt", default_minutes: 12, day_number: 3 },
  { key: "standing_balance", name_en: "Standing Balance", name_th: "ทรงตัวท่ายืน", video_id: "",
    icon: "accessibility_new", default_minutes: 6, day_number: 4 }
]

instructions = [
  { en: "Perform 10–15 reps per set", th: "ทำ 10–15 ครั้งต่อเซ็ต" },
  { en: "2–3 sets with short rests", th: "2–3 เซ็ต พักสั้น ๆ ระหว่างเซ็ต" },
  { en: "Sit tall and move slowly and steadily", th: "นั่งหลังตรง เคลื่อนไหวช้า ๆ อย่างมั่นคง" },
  { en: "Follow the clear step-by-step video", th: "ทำตามวิดีโอทีละขั้นตอน" }
]

exercises = exercises_data.map do |data|
  Exercise.find_or_create_by!(key: data[:key]) do |e|
    e.name_en = data[:name_en]
    e.name_th = data[:name_th]
    e.video_id = data[:video_id]
    e.icon = data[:icon]
    e.default_minutes = data[:default_minutes]
    e.instructions = instructions
  end
end

# Somchai's plan: the first 3 are recommended; 1 and 3 are in "My Plan"
# (mirrors ExercisePlanScreen's _allExercises / _myPlan mocks).
exercises_data.zip(exercises).each_with_index do |(data, exercise), index|
  next if index == 3 # standing_balance isn't in the recommended set either

  PatientExercisePlan.find_or_create_by!(patient: somchai, exercise: exercise) do |p|
    p.day_number = data[:day_number]
    p.minutes = data[:default_minutes]
    p.in_my_plan = [0, 2].include?(index)
    p.position = index
  end
end

puts "Seeding articles..."

article_body = [
  "Sarcopenia is the gradual loss of muscle mass, strength and function that often comes with ageing. It can make everyday tasks — standing up, climbing stairs, carrying shopping — feel harder over time.",
  "The good news is that it can be slowed and even improved. Regular strength activity and eating enough protein are two of the most effective steps you can take at any age.",
  "Small, consistent habits matter most. A short daily walk, a few seated exercises, and a protein source at each meal all add up to stronger, healthier muscles."
]
article_body_th = [
  "ภาวะมวลกล้ามเนื้อน้อย (Sarcopenia) คือการสูญเสียมวล ความแข็งแรง และการทำงานของกล้ามเนื้ออย่างค่อยเป็นค่อยไป ซึ่งมักมากับวัยที่เพิ่มขึ้น อาจทำให้กิจวัตรประจำวัน เช่น การลุกยืน การขึ้นบันได การถือของ ยากขึ้นเมื่อเวลาผ่านไป",
  "ข่าวดีคือ ภาวะนี้สามารถชะลอและแม้แต่ทำให้ดีขึ้นได้ การออกกำลังกายเสริมความแข็งแรงอย่างสม่ำเสมอและการกินโปรตีนให้เพียงพอ เป็นสองสิ่งที่ได้ผลที่สุดที่คุณทำได้ในทุกวัย",
  "นิสัยเล็ก ๆ ที่ทำสม่ำเสมอสำคัญที่สุด การเดินสั้น ๆ ทุกวัน การออกกำลังกายท่านั่งไม่กี่ท่า และแหล่งโปรตีนในทุกมื้อ ล้วนรวมกันเป็นกล้ามเนื้อที่แข็งแรงและสุขภาพดีขึ้น"
]

articles_data = [
  { category: :general, icon: "menu_book_outlined", title_en: "Overview", title_th: "ภาพรวม",
    summary_en: "A quick introduction to muscle health", summary_th: "แนะนำสุขภาพกล้ามเนื้อโดยสังเขป" },
  { category: :general, icon: "help_outline", title_en: "What is Sarcopenia?", title_th: "ภาวะมวลกล้ามเนื้อน้อยคืออะไร?",
    summary_en: "Understanding age-related muscle loss", summary_th: "ทำความเข้าใจการสูญเสียกล้ามเนื้อตามวัย" },
  { category: :prevention, icon: "report_outlined", title_en: "Causes and Risk Factors", title_th: "สาเหตุและปัจจัยเสี่ยง",
    summary_en: "What raises your risk", summary_th: "อะไรเพิ่มความเสี่ยงของคุณ" },
  { category: :exercise, icon: "fitness_center", title_en: "Exercise Guide", title_th: "คู่มือออกกำลังกาย",
    summary_en: "Safe movements to stay strong", summary_th: "ท่าที่ปลอดภัยเพื่อความแข็งแรง" },
  { category: :food, icon: "restaurant_menu", title_en: "Nutrition", title_th: "โภชนาการ",
    summary_en: "Eating well for your muscles", summary_th: "กินอย่างดีเพื่อกล้ามเนื้อ" },
  { category: :prevention, icon: "shield_outlined", title_en: "Prevention", title_th: "การป้องกัน",
    summary_en: "Daily habits that protect you", summary_th: "นิสัยประจำวันที่ปกป้องคุณ" }
]

articles_data.each_with_index do |data, index|
  Article.find_or_create_by!(title_en: data[:title_en]) do |a|
    a.category = data[:category]
    a.icon = data[:icon]
    a.summary_en = data[:summary_en]
    a.summary_th = data[:summary_th]
    a.title_th = data[:title_th]
    a.body_en = article_body
    a.body_th = article_body_th
    a.read_minutes = 3
    a.position = index
  end
end

puts "Seeding reminders for Somchai..."

reminders_data = [
  { kind: :breakfast, time_of_day: "07:00", enabled: true },
  { kind: :lunch, time_of_day: "12:00", enabled: true },
  { kind: :dinner, time_of_day: "18:30", enabled: true },
  { kind: :water, time_of_day: nil, enabled: true },
  { kind: :exercise, time_of_day: "17:00", enabled: false },
  { kind: :medication, time_of_day: "09:00", enabled: true },
  { kind: :sleep, time_of_day: "22:00", enabled: true }
]

reminders_data.each do |data|
  Reminder.find_or_create_by!(patient: somchai, kind: data[:kind]) do |r|
    r.time_of_day = data[:time_of_day]
    r.enabled = data[:enabled]
  end
end

puts "Done. Demo accounts (password: password123):"
puts "  Patient:   #{somchai.phone_number} (#{somchai.full_name})"
puts "  Caretaker: #{malee.phone_number} (#{malee.full_name})"
