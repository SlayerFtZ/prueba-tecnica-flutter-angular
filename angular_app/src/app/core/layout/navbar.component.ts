import { ChangeDetectionStrategy, Component, output } from '@angular/core';

@Component({
  selector: 'app-navbar',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <header class="navbar">
      <button type="button" aria-label="Alternar menú" (click)="toggleMenu.emit()">☰</button>
      <strong>Admin Panel</strong>
    </header>
  `,
  styles: `
    .navbar { display: flex; align-items: center; gap: 1rem; padding: 0.75rem 1rem;
              background: #1f2937; color: #fff; }
    button { background: none; border: 0; color: inherit; font-size: 1.25rem; cursor: pointer; }
  `,
})
export class NavbarComponent {
  readonly toggleMenu = output<void>();
}
