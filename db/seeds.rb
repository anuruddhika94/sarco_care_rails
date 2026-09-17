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

puts "Seeding the 7-day meal plan..."

# Content changes between days, not just additions, so replace wholesale
# rather than find_or_create_by (which would skip updating existing rows).
MealPlanDay.destroy_all

meal_plan_data = [
  {
    day_number: 1, label_en: "Day 1", label_th: "วันที่ 1",
    day_total_en: "~50–53 g/day", day_total_th: "~50–53 กรัม/วัน",
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
      { slot: :before_bed, title_en: "Plain milk · 1 glass", title_th: "นมจืด 1 แก้ว",
        icon: "local_drink_outlined", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Plain milk · 200 ml", name_th: "นมจืด 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 2, label_en: "Day 2", label_th: "วันที่ 2",
    day_total_en: "~50–54 g/day", day_total_th: "~50–54 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Minced chicken congee + ½ boiled egg", title_th: "โจ๊กไก่สับ + ไข่ต้ม ½ ฟอง",
        icon: "rice_bowl", total_protein_en: "~13 g", total_protein_th: "~13 กรัม", image: "assets/images/meals/plan_d2_breakfast.jpg",
        items: [
          { name_en: "Rice porridge · 1 small bowl", name_th: "ข้าวโจ๊ก 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Minced chicken · 40 g", name_th: "ไก่สับ 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + mild minced chicken basil + tofu", title_th: "ข้าว + ผัดกะเพราไก่สับ (ไม่เผ็ด) + เต้าหู้",
        icon: "ramen_dining", total_protein_en: "~15 g", total_protein_th: "~15 กรัม", image: "assets/images/meals/plan_d2_lunch.jpg",
        items: [
          { name_en: "Minced chicken (mild, no chili) · 50 g", name_th: "ไก่สับผัดกะเพราไม่เผ็ด 50 กรัม", protein_en: "~11 g", protein_th: "~11 กรัม" },
          { name_en: "Tofu · ⅓ tube", name_th: "เต้าหู้ ⅓ หลอด", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Ivy gourd, tofu & pork clear soup + rice", title_th: "แกงจืดตำลึงเต้าหู้หมูสับ + ข้าว",
        icon: "soup_kitchen", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d2_dinner.jpg",
        items: [
          { name_en: "Lean minced pork · 45 g", name_th: "หมูสับไม่ติดมัน 45 กรัม", protein_en: "~9 g", protein_th: "~9 กรัม" },
          { name_en: "Tofu · ½ tube", name_th: "เต้าหู้ ½ หลอด", protein_en: "~4 g", protein_th: "~4 กรัม" },
          { name_en: "Ivy gourd · ½ cup", name_th: "ตำลึง ½ ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :snack, title_en: "Plain yogurt · 1 cup", title_th: "โยเกิร์ตรสธรรมชาติ 1 ถ้วย",
        icon: "icecream", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Plain yogurt · 1 cup", name_th: "โยเกิร์ตรสธรรมชาติ 1 ถ้วย", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 3, label_en: "Day 3", label_th: "วันที่ 3",
    day_total_en: "~51–55 g/day", day_total_th: "~51–55 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Fish congee + steamed egg", title_th: "ข้าวต้มปลา + ไข่ตุ๋น",
        icon: "rice_bowl", total_protein_en: "~14 g", total_protein_th: "~14 กรัม", image: "assets/images/meals/plan_d3_breakfast.jpg",
        items: [
          { name_en: "Fish · 40 g", name_th: "เนื้อปลา 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Rice congee · 1 small bowl", name_th: "ข้าวต้ม 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Steamed egg", name_th: "ไข่ตุ๋น", protein_en: "~4 g", protein_th: "~4 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + soft ginger chicken + blanched veg", title_th: "ข้าว + ไก่ผัดขิง (แบบนุ่ม) + ผักลวก",
        icon: "egg_alt", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d3_lunch.jpg",
        items: [
          { name_en: "Soft-cooked chicken breast · 55 g", name_th: "อกไก่ผัดขิงเนื้อนุ่ม 55 กรัม", protein_en: "~13 g", protein_th: "~13 กรัม" },
          { name_en: "Blanched vegetables · 1 cup", name_th: "ผักลวก 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Steamed soy fish + napa cabbage & tofu soup", title_th: "ปลานึ่งซีอิ๊ว + แกงจืดผักกาดขาวเต้าหู้",
        icon: "set_meal", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d3_dinner.jpg",
        items: [
          { name_en: "Fish · 50 g", name_th: "เนื้อปลา 50 กรัม", protein_en: "~10 g", protein_th: "~10 กรัม" },
          { name_en: "Napa cabbage & tofu · ½ tube", name_th: "ผักกาดขาวและเต้าหู้ ½ หลอด", protein_en: "~4 g", protein_th: "~4 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :before_bed, title_en: "Plain milk · 1 glass", title_th: "นมจืด 1 แก้ว",
        icon: "local_drink_outlined", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Plain milk · 200 ml", name_th: "นมจืด 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 4, label_en: "Day 4", label_th: "วันที่ 4",
    day_total_en: "~50–53 g/day", day_total_th: "~50–53 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Minced pork congee + steamed egg", title_th: "โจ๊กหมูสับ + ไข่ตุ๋น",
        icon: "rice_bowl", total_protein_en: "~13 g", total_protein_th: "~13 กรัม", image: "assets/images/meals/plan_d4_breakfast.jpg",
        items: [
          { name_en: "Lean minced pork · 35 g", name_th: "หมูสับไม่ติดมัน 35 กรัม", protein_en: "~7 g", protein_th: "~7 กรัม" },
          { name_en: "Rice porridge · 1 small bowl", name_th: "ข้าวโจ๊ก 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Steamed egg", name_th: "ไข่ตุ๋น", protein_en: "~4 g", protein_th: "~4 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + topped tofu with minced pork + boiled veg", title_th: "ข้าว + เต้าหู้ทรงเครื่องหมูสับ + ผักต้ม",
        icon: "ramen_dining", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d4_lunch.jpg",
        items: [
          { name_en: "Tofu · ½ tube", name_th: "เต้าหู้ ½ หลอด", protein_en: "~4 g", protein_th: "~4 กรัม" },
          { name_en: "Lean minced pork topping · 45 g", name_th: "หมูสับหน้าเต้าหู้ 45 กรัม", protein_en: "~9 g", protein_th: "~9 กรัม" },
          { name_en: "Boiled vegetables · 1 cup", name_th: "ผักต้ม 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Soft fish & vegetable soup + rice", title_th: "แกงเลียงปลาแบบเนื้อนิ่ม + ข้าว",
        icon: "soup_kitchen", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d4_dinner.jpg",
        items: [
          { name_en: "Fish · 55 g", name_th: "เนื้อปลา 55 กรัม", protein_en: "~12 g", protein_th: "~12 กรัม" },
          { name_en: "Mixed vegetables · 1 cup", name_th: "ผักรวม 1 ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :before_bed, title_en: "Unsweetened soy milk · 1 glass", title_th: "นมถั่วเหลืองไม่หวาน 1 แก้ว",
        icon: "local_drink_outlined", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Unsweetened soy milk · 200 ml", name_th: "นมถั่วเหลืองไม่หวาน 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 5, label_en: "Day 5", label_th: "วันที่ 5",
    day_total_en: "~50–54 g/day", day_total_th: "~50–54 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Shredded chicken congee + ½ boiled egg", title_th: "ข้าวต้มไก่ฉีก + ไข่ต้ม ½ ฟอง",
        icon: "rice_bowl", total_protein_en: "~13 g", total_protein_th: "~13 กรัม", image: "assets/images/meals/plan_d5_breakfast.jpg",
        items: [
          { name_en: "Shredded chicken · 40 g", name_th: "ไก่ฉีก 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Rice congee · 1 small bowl", name_th: "ข้าวต้ม 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + ginger fish + tofu clear soup", title_th: "ข้าว + ปลาผัดขิง + แกงจืดเต้าหู้",
        icon: "set_meal", total_protein_en: "~16 g", total_protein_th: "~16 กรัม", image: "assets/images/meals/plan_d5_lunch.jpg",
        items: [
          { name_en: "Fish stir-fried with ginger · 50 g", name_th: "ปลาผัดขิง 50 กรัม", protein_en: "~11 g", protein_th: "~11 กรัม" },
          { name_en: "Tofu · ½ tube", name_th: "เต้าหู้ ½ หลอด", protein_en: "~3 g", protein_th: "~3 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Clear fish tom yum + boiled veg + rice", title_th: "ต้มยำปลาแบบน้ำใส + ผักต้ม + ข้าว",
        icon: "soup_kitchen", total_protein_en: "~15 g", total_protein_th: "~15 กรัม", image: "assets/images/meals/plan_d5_dinner.jpg",
        items: [
          { name_en: "Fish · 55 g", name_th: "เนื้อปลา 55 กรัม", protein_en: "~12 g", protein_th: "~12 กรัม" },
          { name_en: "Boiled vegetables · 1 cup", name_th: "ผักต้ม 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :snack, title_en: "Plain yogurt", title_th: "โยเกิร์ตรสธรรมชาติ",
        icon: "icecream", total_protein_en: "~6–7 g", total_protein_th: "~6–7 กรัม", image: nil,
        items: [
          { name_en: "Plain yogurt · 1 small cup", name_th: "โยเกิร์ตรสธรรมชาติ 1 ถ้วยเล็ก", protein_en: "~6–7 g", protein_th: "~6–7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 6, label_en: "Day 6", label_th: "วันที่ 6",
    day_total_en: "~51–54 g/day", day_total_th: "~51–54 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Fish congee + steamed egg", title_th: "โจ๊กปลา + ไข่ตุ๋น",
        icon: "rice_bowl", total_protein_en: "~14 g", total_protein_th: "~14 กรัม", image: "assets/images/meals/plan_d6_breakfast.jpg",
        items: [
          { name_en: "Fish · 40 g", name_th: "เนื้อปลา 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Rice porridge · 1 small bowl", name_th: "ข้าวโจ๊ก 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Steamed egg", name_th: "ไข่ตุ๋น", protein_en: "~4 g", protein_th: "~4 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + chicken stewed with shiitake + steamed veg", title_th: "ข้าว + ไก่ตุ๋นเห็ดหอม + ผักนึ่ง",
        icon: "ramen_dining", total_protein_en: "~17 g", total_protein_th: "~17 กรัม", image: "assets/images/meals/plan_d6_lunch.jpg",
        items: [
          { name_en: "Chicken stewed with shiitake · 60 g", name_th: "ไก่ตุ๋นเห็ดหอม 60 กรัม", protein_en: "~13 g", protein_th: "~13 กรัม" },
          { name_en: "Shiitake mushroom", name_th: "เห็ดหอม", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Steamed vegetables · 1 cup", name_th: "ผักนึ่ง 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Glass noodle, tofu & pork clear soup + rice", title_th: "แกงจืดวุ้นเส้นเต้าหู้หมูสับ + ข้าว",
        icon: "soup_kitchen", total_protein_en: "~15 g", total_protein_th: "~15 กรัม", image: "assets/images/meals/plan_d6_dinner.jpg",
        items: [
          { name_en: "Lean minced pork · 40 g", name_th: "หมูสับไม่ติดมัน 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Tofu · ½ tube", name_th: "เต้าหู้ ½ หลอด", protein_en: "~4 g", protein_th: "~4 กรัม" },
          { name_en: "Glass noodles", name_th: "วุ้นเส้น", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :before_bed, title_en: "Plain milk · 1 glass", title_th: "นมจืด 1 แก้ว",
        icon: "local_drink_outlined", total_protein_en: "~7 g", total_protein_th: "~7 กรัม", image: nil,
        items: [
          { name_en: "Plain milk · 200 ml", name_th: "นมจืด 200 มล.", protein_en: "~7 g", protein_th: "~7 กรัม" }
        ] }
    ]
  },
  {
    day_number: 7, label_en: "Day 7", label_th: "วันที่ 7",
    day_total_en: "~50–55 g/day", day_total_th: "~50–55 กรัม/วัน",
    meals: [
      { slot: :breakfast, title_en: "Minced pork congee + ½ boiled egg", title_th: "ข้าวต้มหมูสับ + ไข่ต้ม ½ ฟอง",
        icon: "rice_bowl", total_protein_en: "~13 g", total_protein_th: "~13 กรัม", image: "assets/images/meals/plan_d7_breakfast.jpg",
        items: [
          { name_en: "Rice congee · 1 small bowl", name_th: "ข้าวต้ม 1 ถ้วยเล็ก", protein_en: "~2 g", protein_th: "~2 กรัม" },
          { name_en: "Lean minced pork · 40 g", name_th: "หมูสับไม่ติดมัน 40 กรัม", protein_en: "~8 g", protein_th: "~8 กรัม" },
          { name_en: "Boiled egg · ½", name_th: "ไข่ต้ม ½ ฟอง", protein_en: "~3 g", protein_th: "~3 กรัม" }
        ] },
      { slot: :lunch, title_en: "Rice + steamed soy fish + soft tofu", title_th: "ข้าว + ปลานึ่งซีอิ๊ว + เต้าหู้อ่อน",
        icon: "set_meal", total_protein_en: "~17 g", total_protein_th: "~17 กรัม", image: "assets/images/meals/plan_d7_lunch.jpg",
        items: [
          { name_en: "Fish · 55 g", name_th: "เนื้อปลา 55 กรัม", protein_en: "~12 g", protein_th: "~12 กรัม" },
          { name_en: "Soft tofu · ½ tube", name_th: "เต้าหู้อ่อน ½ หลอด", protein_en: "~3 g", protein_th: "~3 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :dinner, title_en: "Minced chicken & veg clear soup + steamed veg + rice", title_th: "แกงจืดไก่สับผัก + ผักนึ่ง + ข้าว",
        icon: "soup_kitchen", total_protein_en: "~15 g", total_protein_th: "~15 กรัม", image: "assets/images/meals/plan_d7_dinner.jpg",
        items: [
          { name_en: "Minced chicken · 55 g", name_th: "ไก่สับ 55 กรัม", protein_en: "~11 g", protein_th: "~11 กรัม" },
          { name_en: "Vegetables in soup · 1 cup", name_th: "ผักในแกงจืด 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Steamed vegetables · 1 cup", name_th: "ผักนึ่ง 1 ถ้วย", protein_en: "~1 g", protein_th: "~1 กรัม" },
          { name_en: "Rice · ½ bowl", name_th: "ข้าวสวย ½ ถ้วย", protein_en: "~2 g", protein_th: "~2 กรัม" }
        ] },
      { slot: :before_bed, title_en: "Plain milk or yogurt · 1 cup", title_th: "นมจืด/โยเกิร์ต 1 ถ้วย",
        icon: "local_drink_outlined", total_protein_en: "~7–8 g", total_protein_th: "~7–8 กรัม", image: nil,
        items: [
          { name_en: "Plain milk or yogurt · 1 cup", name_th: "นมจืด/โยเกิร์ต 1 ถ้วย", protein_en: "~7–8 g", protein_th: "~7–8 กรัม" }
        ] }
    ]
  }
]

meal_plan_data.each do |day_data|
  day = MealPlanDay.create!(
    day_number: day_data[:day_number],
    label_en: day_data[:label_en],
    label_th: day_data[:label_th],
    day_total_en: day_data[:day_total_en],
    day_total_th: day_data[:day_total_th]
  )

  day_data[:meals].each_with_index do |meal_data, meal_position|
    meal = MealPlanMeal.create!(
      meal_plan_day: day,
      slot: meal_data[:slot],
      title_en: meal_data[:title_en],
      title_th: meal_data[:title_th],
      icon: meal_data[:icon],
      total_protein_en: meal_data[:total_protein_en],
      total_protein_th: meal_data[:total_protein_th],
      image: meal_data[:image],
      position: meal_position
    )

    meal_data[:items].each_with_index do |item_data, item_position|
      MealPlanItem.create!(
        meal_plan_meal: meal,
        name_en: item_data[:name_en],
        name_th: item_data[:name_th],
        protein_en: item_data[:protein_en],
        protein_th: item_data[:protein_th],
        position: item_position
      )
    end
  end
end

puts "Seeding exercises..."

exercises_data = [
  { key: "seated_leg_lift", name_en: "Seated Leg Lift", name_th: "ยกขาท่านั่ง", video_id: "BoA431kaU2M",
    icon: "airline_seat_recline_normal", default_minutes: 10 },
  { key: "arm_curls", name_en: "Arm Curls", name_th: "งอแขนยกน้ำหนัก", video_id: "eZhhNN4QkSk",
    icon: "fitness_center", default_minutes: 8 },
  { key: "chair_squats", name_en: "Chair Squats", name_th: "สควอทกับเก้าอี้", video_id: "7QZKb9E5dbg",
    icon: "chair_alt", default_minutes: 12 }
]

instructions = [
  { en: "Perform 10–15 reps per set", th: "ทำ 10–15 ครั้งต่อเซ็ต" },
  { en: "2–3 sets with short rests", th: "2–3 เซ็ต พักสั้น ๆ ระหว่างเซ็ต" },
  { en: "Sit tall and move slowly and steadily", th: "นั่งหลังตรง เคลื่อนไหวช้า ๆ อย่างมั่นคง" },
  { en: "Follow the clear step-by-step video", th: "ทำตามวิดีโอทีละขั้นตอน" }
]

# The exercise catalog is shared across all patients — no per-patient
# assignment needed.
exercises_data.each do |data|
  Exercise.find_or_create_by!(key: data[:key]) do |e|
    e.name_en = data[:name_en]
    e.name_th = data[:name_th]
    e.video_id = data[:video_id]
    e.icon = data[:icon]
    e.default_minutes = data[:default_minutes]
    e.instructions = instructions
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
