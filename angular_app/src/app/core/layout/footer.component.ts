import { ChangeDetectionStrategy, Component } from '@angular/core';

@Component({
  selector: 'app-footer',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `<footer>© {{ year }} Admin Panel · Datos de dummyjson.com</footer>`,
  styles: `
    footer { padding: 1rem; text-align: center; background: #1f2937; color: #9ca3af;
             font-size: 0.85rem; }
  `,
})
export class FooterComponent {
  protected readonly year = new Date().getFullYear();
}
