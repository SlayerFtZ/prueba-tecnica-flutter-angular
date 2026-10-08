import { ChangeDetectionStrategy, Component, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from './navbar.component';
import { SidebarComponent } from './sidebar.component';
import { FooterComponent } from './footer.component';

@Component({
  selector: 'app-main-layout',
  imports: [RouterOutlet, NavbarComponent, SidebarComponent, FooterComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <app-navbar (toggleMenu)="sidebarOpen.set(!sidebarOpen())" />
    <div class="body">
      <app-sidebar [open]="sidebarOpen()" />
      <main class="content"><router-outlet /></main>
    </div>
    <app-footer />
  `,
  styles: `
    :host { display: flex; flex-direction: column; min-height: 100vh; }
    .body { display: flex; flex: 1; }
    .content { flex: 1; padding: 1.5rem; background: #f5f6fa; min-width: 0; }
  `,
})
export class MainLayoutComponent {
  protected readonly sidebarOpen = signal(true);
}
