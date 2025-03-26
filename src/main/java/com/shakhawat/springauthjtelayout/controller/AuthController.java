package com.shakhawat.springauthjtelayout.controller;

import com.shakhawat.springauthjtelayout.dto.JwtResponse;
import com.shakhawat.springauthjtelayout.dto.LoginRequest;
import com.shakhawat.springauthjtelayout.dto.RegisterRequest;
import com.shakhawat.springauthjtelayout.service.AuthService;
import com.shakhawat.springauthjtelayout.service.JwtTokenBlacklistService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;
    private final JwtTokenBlacklistService tokenBlacklistService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("registerRequest", new RegisterRequest());
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute @Valid RegisterRequest request, BindingResult result, Model model, HttpServletResponse response) throws IOException {
        if (result.hasErrors()) {
            return "register";
        }

        try {
            JwtResponse jwtResponse = authService.register(request);
            response.addHeader("Authorization", "Bearer " + jwtResponse.getToken());
            return "redirect:/dashboard";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        model.addAttribute("loginRequest", new LoginRequest());
        return "login";
    }

    @PostMapping("/authenticate")
    public void login(@ModelAttribute("loginRequest") @Valid LoginRequest request, BindingResult bindingResult, HttpServletRequest httpRequest, HttpServletResponse response) throws IOException {
        if (bindingResult.hasErrors()) {
            response.sendRedirect("/auth/login?error=invalid_input");
            return;
        }

        try {
            JwtResponse jwtResponse = authService.login(request);
            response.addHeader("Authorization", "Bearer " + jwtResponse.getToken());

            // Store token in cookie for browser access if needed
            Cookie authCookie = new Cookie("JWT-TOKEN", jwtResponse.getToken());
            authCookie.setHttpOnly(true);
            authCookie.setSecure(true);
            authCookie.setPath("/");
            response.addCookie(authCookie);

            response.sendRedirect("/dashboard");
        } catch (Exception e) {
            response.sendRedirect("/auth/login?error=auth_failed");
        }
    }

    // API endpoints for mobile/SPA clients
    @PostMapping("/api/register")
    public ResponseEntity<JwtResponse> registerApi(@RequestBody @Valid RegisterRequest request) {
        return ResponseEntity.ok(authService.register(request));
    }

    @PostMapping("/api/login")
    public ResponseEntity<JwtResponse> loginApi(@RequestBody @Valid LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {

        String token = extractToken(request);

        if (token != null) {
            tokenBlacklistService.blacklistToken(token);
        }

        new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());

        return "redirect:/auth/login?logout";
    }

    private String extractToken(HttpServletRequest request) {
        // Check Authorization header
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }

        // Check cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("JWT-TOKEN".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }

        return null;
    }

}
