import { ChangeDetectionStrategy, Component } from '@angular/core';

@Component({
  selector: 'app-footer',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <footer class="flex flex-wrap items-center justify-center gap-x-2 border-t border-blue-100 bg-white px-4 py-4 text-xs text-blue-500">
      <span>© {{ year }} Dashboard</span>
      <span aria-hidden="true">·</span>
      <span>
        Datos de
        <a href="https://dummyjson.com" target="_blank" rel="noopener"
           class="font-semibold text-blue-700 underline decoration-blue-300 decoration-dotted underline-offset-4 hover:text-blue-500">
          dummyjson.com
        </a>
      </span>
    </footer>
  `,
})
export class FooterComponent {
  protected readonly year = new Date().getFullYear();
}
