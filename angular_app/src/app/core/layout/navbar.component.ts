import { ChangeDetectionStrategy, Component, output } from '@angular/core';

@Component({
  selector: 'app-navbar',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <header class="sticky top-0 z-20 flex h-14 items-center gap-3 bg-blue-600 px-4 text-white shadow-md shadow-blue-900/10">
      <button
        type="button"
        aria-label="Alternar menú"
        (click)="toggleMenu.emit()"
        class="grid size-9 place-items-center rounded-lg transition hover:bg-white/15 focus-visible:outline-2 focus-visible:outline-white"
      >
        <svg viewBox="0 0 24 24" class="size-5" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true">
          <path d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>

      <div class="flex items-center gap-2">

        <strong class="text-sm font-semibold tracking-wide">Dashboard</strong>
      </div>


    </header>
  `,
})
export class NavbarComponent {
  readonly toggleMenu = output<void>();
}
