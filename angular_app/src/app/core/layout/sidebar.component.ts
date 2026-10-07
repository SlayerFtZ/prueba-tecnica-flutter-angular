import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';

interface MenuItem {
  label: string;
  path: string;
}

@Component({
  selector: 'app-sidebar',
  imports: [RouterLink, RouterLinkActive],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    @if (open()) {
      <nav class="sidebar">
        @for (item of items; track item.path) {
          <a [routerLink]="item.path" routerLinkActive="active">{{ item.label }}</a>
        }
      </nav>
    }
  `,
  styles: `
    .sidebar { display: flex; flex-direction: column; width: 220px; height: 100%;
               background: #111827; padding: 1rem 0; }
    a { color: #d1d5db; padding: 0.75rem 1.5rem; text-decoration: none; }
    a:hover, a.active { background: #374151; color: #fff; }
  `,
})
export class SidebarComponent {
  readonly open = input(true);

  protected readonly items: MenuItem[] = [
    { label: 'Dashboard', path: '/dashboard' },
    { label: 'Pedidos', path: '/orders' },
    { label: 'Productos', path: '/products' },
  ];
}
