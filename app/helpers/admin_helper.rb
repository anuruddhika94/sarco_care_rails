module AdminHelper
  # Minimal inline-SVG icon set (no asset pipeline in this API-only app, so
  # no icon font/library to load) — stroke-style, 24x24, single color.
  ICON_PATHS = {
    people: '<path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"/>',
    person: '<path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>',
    clock: '<path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 10.41V6h-2v7l5.25 3.15 1-1.64L13 12.41z"/>',
    heart: '<path d="M12 21s-6.7-4.35-9.3-8.55C.86 9.77 1.4 6.3 4.1 4.6c2.15-1.37 4.9-.86 6.4 1.1l1.5 1.95 1.5-1.95c1.5-1.96 4.25-2.47 6.4-1.1 2.7 1.7 3.24 5.17 1.4 7.85C18.7 16.65 12 21 12 21z"/>',
    clipboard: '<path d="M9 3a1 1 0 00-1 1H6a2 2 0 00-2 2v13a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-2a1 1 0 00-1-1H9zm0 4h6v2H9V7zm-2 5h10v2H7v-2zm0 4h7v2H7v-2z"/>',
    phone: '<path d="M6.6 10.8c1.4 2.8 3.8 5.2 6.6 6.6l2.2-2.2c.3-.3.7-.4 1-.2 1.1.4 2.3.6 3.6.6.6 0 1 .4 1 1V20c0 .6-.4 1-1 1C10.6 21 3 13.4 3 4c0-.6.4-1 1-1h3.5c.6 0 1 .4 1 1 0 1.3.2 2.5.6 3.6.1.4 0 .8-.2 1L6.6 10.8z"/>',
    calendar: '<path d="M7 2v2H5a2 2 0 00-2 2v13a2 2 0 002 2h14a2 2 0 002-2V6a2 2 0 00-2-2h-2V2h-2v2H9V2H7zM5 9h14v10H5V9z"/>',
    dumbbell: '<path d="M20.6 9.2l-1.4-1.4-1.1 1.1-2-2 1.1-1.1L15.8 4.4l-1.1 1.1-1-1-1.4 1.4 1 1-3.4 3.4-1-1-1.4 1.4 1.1 1.1-2 2-1.1-1.1L3.1 14l1.1 1.1-1 1 1.4 1.4 1-1 2 2-1.1 1.1 1.4 1.4 1.1-1.1 1 1 1.4-1.4-1-1 3.4-3.4 1 1 1.4-1.4-1.1-1.1 2-2 1.1 1.1 1.4-1.4-1.1-1.1 1-1z"/>',
    meal: '<path d="M8.1 13.34l2.83-2.83L3.91 3.5a4.008 4.008 0 000 5.66l4.19 4.18zm6.78-1.81c1.53.71 3.68.21 5.27-1.38 1.91-1.91 2.28-4.65.81-6.12-1.46-1.47-4.2-1.1-6.12.81-1.59 1.59-2.09 3.74-1.38 5.27L3.7 19.87l1.41 1.41L12 14.41l6.88 6.88 1.41-1.41L13.41 13l1.47-1.47z"/>',
    chevron: '<path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>',
    warning: '<path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/>'
  }.freeze

  def admin_icon(name, size: 20)
    path = ICON_PATHS.fetch(name)
    raw(%(<svg width="#{size}" height="#{size}" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">#{path}</svg>)) # rubocop:disable Rails/OutputSafety
  end

  def icon_badge(name, color: "primary", size: 44)
    content_tag(:div, admin_icon(name, size: size * 0.5), class: "icon-badge icon-badge-#{color}", style: "width:#{size}px;height:#{size}px")
  end

  def initials(full_name)
    full_name.to_s.split.map { |w| w[0] }.first(2).join.upcase
  end

  AVATAR_COLORS = %w[a b c d e].freeze

  def avatar(full_name, size: 40)
    color = AVATAR_COLORS[full_name.to_s.sum % AVATAR_COLORS.length]
    content_tag(:div, initials(full_name), class: "avatar avatar-#{color}",
      style: "width:#{size}px;height:#{size}px;line-height:#{size}px;font-size:#{(size * 0.4).round}px")
  end
end
