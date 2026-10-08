import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';

interface MenuItem {
  label: string;
  path: string;
  icon: string;
}

@Component({
  selector: 'app-sidebar',
  imports: [RouterLink, RouterLinkActive],
  changeDetection: ChangeDetectionStrategy.OnPush,
  host: { class: 'block' },
  template: `
    <nav
      aria-label="Navegación principal"
      [attr.inert]="open() ? null : ''"
      class="h-full overflow-hidden whitespace-nowrap border-blue-100 bg-white transition-all duration-200"
      [class]="open() ? 'w-60 border-r p-3' : 'w-0 border-r-0 p-0'"
    >
      <p class="mb-2 px-3 text-[11px] font-semibold uppercase tracking-wider text-blue-400">Menú</p>

      <ul class="flex flex-col gap-1">
        @for (item of items; track item.path) {
          <li>
            <a
              [routerLink]="item.path"
              routerLinkActive="!bg-blue-600 !text-white shadow-sm shadow-blue-600/30"
              class="flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium text-blue-900 transition hover:bg-blue-50 hover:text-blue-700 focus-visible:outline-2 focus-visible:outline-blue-500"
            >
              <svg viewBox="0 0 24 24" class="size-[18px]" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path [attr.d]="item.icon" />
              </svg>
              {{ item.label }}
            </a>
          </li>
        }
      </ul>
    </nav>
  `,
})
export class SidebarComponent {
  readonly open = input(true);

  protected readonly items: MenuItem[] = [
    { label: 'Dashboard', path: '/dashboard', icon: 'M3 3h7v9H3zM14 3h7v5h-7zM14 12h7v9h-7zM3 16h7v5H3z' },
    { label: 'Pedidos', path: '/orders', icon: 'M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4zM3 6h18M16 10a4 4 0 0 1-8 0' },
    { label: 'Productos', path: '/products', icon: 'M21 8 12 3 3 8v8l9 5 9-5zM3 8l9 5 9-5M12 13v8' },
  ];
}
